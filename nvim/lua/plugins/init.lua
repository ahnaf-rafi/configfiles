return {
  -- lua functions that many plugins use
  {"nvim-lua/plenary.nvim"},

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd("colorscheme catppuccin-latte")
  --   end,
  -- }
  --

  {
    "ellisonleao/gruvbox.nvim",
    -- Load this before all the other start plugins
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      -- load the colorscheme here
      vim.cmd("colorscheme gruvbox")
    end,
  },

  { "lewis6991/spaceless.nvim" },

  {
    "cappyzawa/trim.nvim",
    opts = {
      trim_on_write = false
    }
  },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   -- opts = {},
  --   config = function()
  --     -- load the colorscheme here
  --     -- vim.cmd("colorscheme tokyonight")

  --     -- There are also colorschemes for the different styles.
  --     -- vim.cmd("colorscheme tokyonight-night")
  --     -- vim.cmd("colorscheme tokyonight-storm")
  --     -- vim.cmd("colorscheme tokyonight-day")
  --     vim.cmd("colorscheme tokyonight-moon")
  --   end,
  -- },

  -- {
  --   "miikanissi/modus-themes.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   -- opts = {},
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd("colorscheme modus")
  --   end,
  -- },

  { "junegunn/fzf", build = "./install --bin" },
  { "junegunn/fzf.vim" }, -- Think about the following: set rtp+=/opt/homebrew/opt/fzf
}
