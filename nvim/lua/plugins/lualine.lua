return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    -- Configure lazy pending updates count.
    local lazy_status = require("lazy.status")

    require("lualine").setup({
      options = { theme = 'gruvbox' },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
          'branch',
          'diff',
          {'diagnostics', sources = {'nvim_diagnostic'}}
        },
        lualine_c = {'filename'},
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates
          },
          {'encoding'},
          {'fileformat'},
          {'filetype'}
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    })
  end
}
