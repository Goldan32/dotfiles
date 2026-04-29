return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'igorlfs/nvim-dap-view',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require 'dap'
      local dap_view = require 'dap-view'

      require('nvim-dap-virtual-text').setup {}
      dap_view.setup {}

      -- Change this if codelldb is somewhere else.
      -- Arch: pacman -S codelldb
      -- macOS: brew install codelldb
      -- Or download vscode-lldb and point to extension/adapter/codelldb
      local codelldb = vim.fn.exepath 'codelldb'
      if codelldb == '' then
        vim.notify('codelldb not found in PATH. Install it or edit the codelldb path in dap.lua', vim.log.levels.WARN)
      end

      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb ~= '' and codelldb or 'codelldb',
          args = { '--port', '${port}' },
        },
      }

      local function pick_executable()
        return vim.fn.input {
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        }
      end

      dap.configurations.c = {
        {
          name = 'Launch executable',
          type = 'codelldb',
          request = 'launch',
          program = pick_executable,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
        {
          name = 'Attach to process',
          type = 'codelldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }

      dap.configurations.cpp = dap.configurations.c

      dap.configurations.rust = {
        {
          name = 'Launch Rust executable',
          type = 'codelldb',
          request = 'launch',
          program = pick_executable,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
        {
          name = 'Debug cargo-built binary',
          type = 'codelldb',
          request = 'launch',
          program = function()
            vim.fn.system 'cargo build'
            return pick_executable()
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DiagnosticWarn' })

      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP continue' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP step over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP step into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP step out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'DAP breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'DAP conditional breakpoint' })
      vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'DAP REPL' })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'DAP run last' })
      vim.keymap.set('n', '<leader>dv', dap_view.toggle, { desc = 'DAP view toggle' })

      dap.listeners.before.attach.dap_view_config = function()
        dap_view.open()
      end
      dap.listeners.before.launch.dap_view_config = function()
        dap_view.open()
      end
      dap.listeners.before.event_terminated.dap_view_config = function()
        dap_view.close()
      end
      dap.listeners.before.event_exited.dap_view_config = function()
        dap_view.close()
      end
    end,
  },
}
