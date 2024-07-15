return {
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
    config = function()
      local wk = require 'which-key'
      wk.add {
        { '\\f', '<cmd>Git<cr>', desc = 'Open git status', mode = 'n' },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
