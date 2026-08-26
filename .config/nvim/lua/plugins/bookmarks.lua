return {
  'LintaoAmons/bookmarks.nvim',
  -- pin the plugin at specific version for stability
  -- backup your bookmark sqlite db when there are breaking changes (major version change)
  tag = 'v4.0.0',
  dependencies = {
    { 'kkharji/sqlite.lua' },
    -- picker backend (choose one):
    -- {"folke/snacks.nvim"},              -- default picker backend
    { 'nvim-telescope/telescope.nvim' }, -- set picker.picker_backend = "telescope" to use
  },
  config = function()
    local opts = {
      picker = {
        picker_backend = 'telescope',
      },
    }
    require('bookmarks').setup(opts) -- you must call setup to init sqlite db

    vim.keymap.set({ 'n', 'v' }, '<leader>m', ':BookmarksGoto<CR>', { desc = 'Goto Book[m]ark' })
    vim.keymap.set({ 'n', 'v' }, '<leader>M', ':BookmarksMark<CR>', { desc = 'Create Book[M]ark' })
  end,
}

-- run :BookmarksInfo to see the running status of the plugin
