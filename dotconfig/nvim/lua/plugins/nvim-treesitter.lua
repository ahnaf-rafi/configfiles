return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local langs = {
      "bash",
      "bibtex",
      "csv",
      "git_config",
      "gitcommit",
      "gitignore",
      "julia",
      -- "latex",
      "lua",
      "markdown",
      "markdown_inline",
      "r",
      "rnoweb",
      "typst",
      "vim",
      "vimdoc",
      "yaml"
    }

    require("nvim-treesitter").install(langs)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = langs,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
