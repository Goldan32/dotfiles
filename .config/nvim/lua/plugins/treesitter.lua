return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    local ts = require 'nvim-treesitter'

    ts.setup()

    local parsers = {
      'bash',
      'c',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
      'typescript',
      'tsx',
      'javascript',
      'json',
      'css',
      'gitcommit',
      'rust',
    }

    for _, parser in ipairs(parsers) do
      ts.install(parser)
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if not lang or lang == 'ruby' then
          return
        end

        pcall(vim.treesitter.start, args.buf, lang)

        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
