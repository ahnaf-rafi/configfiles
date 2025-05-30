return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    -- local nvimtree = require("nvim-tree")
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- OR setup with some options
    require("nvim-tree").setup({
      -- sort_by = "case_sensitive",
      view = {
        width = 35,
        relativenumber = true,
      },

      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },

      git = {
        ignore = false,
      },

      filters = {
        dotfiles = true,
        custom = { ".DS_Store" },
      },
    })

    -- set keymaps
    local keyset = vim.keymap.set -- for conciseness

    keyset("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", {
      desc = "Toggle file explorer"
    })
    keyset("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", {
      desc = "Toggle file explorer on current file"
    })
    keyset("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", {
      desc = "Collapse file explorer"
    })
    keyset("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", {
      desc = "Refresh file explorer"
    })
  end
}
