return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    style = 'warmer',
    colors = {
      bg = '#202020',
    },
    hightlights = {},
  },
  init = function()
    vim.cmd.colorscheme 'onedark'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
