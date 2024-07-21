return {
  {
    'vimwiki/vimwiki',
    lazy = false,
    init = function()
      vim.g.vimwiki_list = { {
        path = '~/Sync/wiki/',
        syntax = 'markdown',
        ext = '.md',
      } }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
      vim.g.vimwiki_global_ext = 0 -- don't treat all md files as vimwiki

      local wk = require 'which-key'
      wk.add {
        { '<leader>ws', ':VimwikiSearch ', desc = 'Search in vim wiki' },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
