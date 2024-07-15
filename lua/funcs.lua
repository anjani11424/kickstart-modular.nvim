-- Create a function to set indentation
local set_indentation = function(filetype, shiftwidth, tabstop, expandtab)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetype,
    callback = function()
      vim.bo.shiftwidth = shiftwidth
      vim.bo.tabstop = tabstop
      vim.bo.expandtab = expandtab
    end,
  })
end

-- Set indentation for Python files
set_indentation('python', 4, 4, true)

-- Set indentation for JavaScript files
set_indentation('javascript', 2, 2, true)

-- Set indentation for HTML files
set_indentation('html', 2, 2, true)

-- Set indentation for C files
set_indentation('c', 3, 3, true)

-- Set indentation for Cpp files
set_indentation('cpp', 3, 3, true)

-- Set indentation for other file types as needed
