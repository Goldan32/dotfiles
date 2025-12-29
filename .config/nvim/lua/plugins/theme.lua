return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    on_colors = function(colors)
      colors.bg = '#202020'
      colors.fg_dark = '#777777'
      colors.bg_statusline = '#202020'
      colors.bg_sidebar = '#1a1a1a'
      colors.fg_gutter = '#303030'
      colors.bg_highlight = '#303030'
    end,
    on_highlights = function(hl, c)
      for _, group in ipairs {
        'NormalFloat',
        'FloatBorder',
        'Pmenu',
        'TelescopeNormal',
        'TelescopeBorder',
        'TelescopePromptNormal',
        'TelescopePromptBorder',
        'TelescopeResultsNormal',
        'TelescopePreviewNormal',
      } do
        hl[group] = { bg = c.bg }
      end

      hl.NeoTreeDirectoryName = { fg = '#c3b6e3' }
      hl.NeoTreeDirectoryIcon = { fg = '#c3b6e3' }
      hl.NeoTreeStatusLine = { fg = c.fg }
      hl.NeoTreeRootName = { fg = c.fg, bold = true, italic = true }
      hl.NeoTreeFileName = { fg = c.fg }
      hl.NeoTreeFileNameOpened = { fg = c.fg }
      hl.NeoTreeFloatBorder = { fg = c.fg, bg = c.bg }
    end,
  },
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
