return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup()
  end,
  keys = {
    {
      '<leader>sp',
      function()
        require('grug-far').open()
      end,
      desc = 'Search and replace',
    },
  },
}
