return {
  {
    'nyngwang/NeoZoom.lua',
    event = 'VimEnter',
    lazy = false,
    config = function()
      require('neo-zoom').setup {}

      local wk = require 'which-key'
      wk.add {
        { '<leader>z', '<cmd>NeoZoomToggle<cr>', desc = 'Togglw zoom' },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
