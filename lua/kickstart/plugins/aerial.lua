return {
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    backends = { 'treesitter', 'lsp', 'markdown', 'man' },
    config = function()
      require('aerial').setup {
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
        disable_max_lines = 20000,
        layout = {
          max_width = { 60, 0.3 },
          width = nil,
          min_width = 10,
          resize_to_content = true,
          preserve_equality = true,
          -- default_direction = "float",
          placement = 'window',
        },
      }
      -- vim.keymap.set("n", "<leader>ws", ":VimwikiSearch ", {silent=true})
      local wk = require 'which-key'
      wk.add {
        { '<leader>ht', '<cmd>AerialToggle<cr>', desc = 'toggle code map', mode = 'n' },
      }
      -- vim.keymap.set('n', '<leader>ht', '<cmd>AerialToggle<CR>')
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
