local ESP_ENV_SCRIPT = 'cn/container.sh'
local ESP_ENV_FALLBACK = vim.env.ESP_ENV_SCRIPT
local ESP_DEFAULT_TARGET = 'xtensa-esp32-none-elf'

local function read_file(path)
  local f = io.open(path, 'r')
  if not f then
    return nil
  end
  local s = f:read '*a'
  f:close()
  return s
end

local function uses_esp_toolchain(path)
  local s = read_file(path)
  if not s then
    return false
  end
  for line in s:gmatch '[^\r\n]+' do
    if line:match '^%s*channel%s*=%s*["\']esp["\']' then
      return true
    end
  end
  -- legacy plain-text `rust-toolchain` file containing just "esp"
  return s:match '^%s*esp%s*$' ~= nil
end

-- Walk up from root looking for an esp toolchain file.
-- Returns the project dir, the script to run, and the cargo target.
local function esp_project(root)
  if not root then
    return nil
  end
  for dir in vim.fs.parents(root .. '/x') do -- yields root first, then its parents
    for _, name in ipairs { 'rust-toolchain.toml', 'rust-toolchain' } do
      if uses_esp_toolchain(dir .. '/' .. name) then
        local script = dir .. '/' .. ESP_ENV_SCRIPT
        if not vim.uv.fs_stat(script) then
          script = ESP_ENV_FALLBACK
        end
        if not script or not vim.uv.fs_stat(script) then
          vim.schedule(function()
            vim.notify('ESP project detected but ' .. ESP_ENV_SCRIPT .. ' was not found; using host rust-analyzer', vim.log.levels.WARN)
          end)
          return nil
        end
        local cfg = read_file(dir .. '/.cargo/config.toml') or read_file(dir .. '/.cargo/config') or ''
        local target = cfg:match 'target%s*=%s*"([^"]+)"' or ESP_DEFAULT_TARGET
        return dir, script, target
      end
    end
  end
end

return {
  bashls = {},
  ruff = {},
  ty = {},
  nil_ls = {
    settings = {
      ['nil'] = {
        nix = {
          flake = {
            autoArchive = false,
          },
        },
        formatting = {
          command = { 'nixfmt' },
        },
      },
    },
  },
  rust_analyzer = {
    cmd = function(dispatchers, config)
      local dir, script = esp_project(config.root_dir)
      if dir then
        return vim.lsp.rpc.start({ script, 'exec', 'rust-analyzer' }, dispatchers, { cwd = dir })
      end
      return vim.lsp.rpc.start({ 'rust-analyzer' }, dispatchers, { cwd = config.root_dir })
    end,

    -- ESP-only settings, merged over the defaults below
    before_init = function(_, config)
      local dir, _, target = esp_project(config.root_dir)
      if dir then
        config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
          ['rust-analyzer'] = {
            cargo = {
              target = target,
              allTargets = false,
              targetDir = true, -- target/rust-analyzer: no lock contention with builds
            },
            check = { allTargets = false },
          },
        })
      end
    end,

    settings = {
      ['rust-analyzer'] = {
        imports = {
          granularity = {
            group = 'module',
          },
          prefix = 'self',
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
  ts_ls = {},
  clangd = {
    cmd = {
      'clangd',
      '--header-insertion=never',
      '-j=4',
      '--completion-style=detailed',
      '--function-arg-placeholders',
      '--rename-file-limit=0',
      '--background-index',
      '--background-index-priority=normal',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  },
  svelte = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}
