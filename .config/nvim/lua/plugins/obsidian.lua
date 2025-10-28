return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    "BufReadPre " .. vim.fn.expand(os.getenv("OBSIDIAN_DEFAULT_VAULT")) .. "/*.md",
    "BufNewFile " .. vim.fn.expand(os.getenv("OBSIDIAN_DEFAULT_VAULT")) .. "/*.md",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "udc",
        -- path = "~/projects/udc-vault",
        path = os.getenv("OBSIDIAN_DEFAULT_VAULT"),
      },
    },
    frontmatter = {
      enabled = false,
    },
    footer = {
      format = "{{backlinks}} backlinks",
      enabled = true,
    },
    legacy_commands = false,
  },
}
