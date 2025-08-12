return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        -- bash,
        "bibtex",
        "git_config",
        "gitcommit",
        "gitignore",
        "julia",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "r",
        "vim",
        "vimdoc"
      },
      sync_install = true,
      highlight = {
        enable = true,
        -- disable = { "julia" },
        disable = { "latex" },
      },
      indent = {
        enable = true
      },
    })
  end
}
