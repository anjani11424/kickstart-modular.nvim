return {
  {
    'tummetott/unimpaired.nvim',
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('unimpaired').setup {
        -- add any options here or leave empty
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
