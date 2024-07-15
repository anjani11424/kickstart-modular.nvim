-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`

      local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == '.' then
          return tail
        end
        return string.format('%s\t\t%s', tail, parent)
      end

      local actions = require 'telescope.actions'
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          -- prompt_prefix = icons.ui.Telescope .. ' ',
          -- selection_caret = icons.ui.Forward .. ' ',
          -- entry_prefix = " ",
          initial_mode = 'insert',
          path_display = { 'smart' },
          color_devicons = true,
          set_env = { ['COLORTERM'] = 'truecolor' },
          wrap_results = true,
          layout_config = {
            horizontal = {
              prompt_position = 'bottom',
              preview_width = 0.60,
              results_width = 0.7,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!.git/',
          },

          mappings = {
            i = {
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,

              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-s>'] = actions.smart_send_to_qflist + actions.open_qflist,
              ['<C-l>'] = actions.send_selected_to_loclist,
            },
            n = {
              ['<esc>'] = actions.close,
              ['j'] = actions.move_selection_next,
              ['k'] = actions.move_selection_previous,
              ['<C-s>'] = actions.smart_send_to_qflist + actions.open_qflist,
              ['<C-l>'] = actions.send_selected_to_loclist,
            },
          },
        },
        pickers = {
          -- live_grep = {
          --   theme = "dropdown",
          -- },

          -- grep_string = {
          --   theme = "dropdown",
          -- },

          find_files = {
            theme = 'dropdown',
            previewer = false,
            path_display = filenameFirst,
          },

          buffers = {
            theme = 'dropdown',
            previewer = false,
            initial_mode = 'normal',
            mappings = {
              i = {
                ['<C-d>'] = actions.delete_buffer,
              },
              n = {
                ['dd'] = actions.delete_buffer,
              },
            },
          },

          planets = {
            show_pluto = true,
            show_moon = true,
          },

          colorscheme = {
            enable_preview = true,
          },

          lsp_references = {
            theme = 'dropdown',
            initial_mode = 'normal',
          },

          lsp_definitions = {
            theme = 'dropdown',
            initial_mode = 'normal',
          },

          lsp_declarations = {
            theme = 'dropdown',
            initial_mode = 'normal',
          },

          lsp_implementations = {
            theme = 'dropdown',
            initial_mode = 'normal',
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sw', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>ss', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
