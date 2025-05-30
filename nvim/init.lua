if vim.g.vscode then
  -- VSCode extension
  local keymap = vim.keymap.set
  local opts = {silent = true, noremap = true}

  --  NOTE: Must happen before plugins are required (otherwise wrong leader will
  --  be used)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " m"

  keymap("v", "<", "<gv", opts)                   -- Better indent in visual
  keymap("v", ">", ">gv", opts)                   -- Better dedent in visual
  keymap("i", "fd", "<esc>", opts)                -- fd = esc in insert
  keymap("v", "fd", "<esc>", opts)                -- fd = esc in visual

else
  local opt = vim.opt  -- for conciseness

  -- Line numbers, make them relative.
  opt.number = true
  opt.relativenumber = true

  -- Adjust splitting behavior
  opt.splitbelow = true
  opt.splitright = true

  -- Set highlight on search
  opt.hlsearch = false

  -- Case-insensitive searching UNLESS \C or capital in search
  opt.incsearch  = true
  opt.ignorecase = true
  opt.smartcase  = true

  -- Tabs and indentation
  opt.cindent     = false
  opt.autoindent  = true
  opt.smartindent = true
  opt.tabstop     = 2
  opt.softtabstop = 2
  opt.shiftwidth  = 2
  opt.expandtab   = true

  -- Enable mouse mode
  opt.mouse = 'a'

  -- Sync clipboard between OS and Neovim. See `:help 'clipboard'`
  opt.clipboard = 'unnamedplus'

  -- Save undo history
  opt.undofile = true

  -- Keep signcolumn on by default
  opt.signcolumn = 'yes'

  -- Enable break indent
  opt.breakindent = true

  -- Break lines at
  opt.linebreak = true

  -- Column indicators
  opt.colorcolumn = '81,101,121'

  -- Highlight current line
  opt.cursorline = true

  -- Color theme
  opt.background = "dark"

  -- Disable vim folds
  opt.foldenable = false

  -- Some globals
  vim.g.python3_host_prog   = '~/miniforge3/bin/python3'
  vim.g.tex_flavor          = 'latex'
  vim.g.tex_comment_nospell = 1
  -- vim.g.tex_nospell      = 1

  vim.cmd('set iskeyword-=_')


  -- Basic keymaps
  require('keymaps')

  -- Plugin management with lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
      "git", "clone", "--filter=blob:none", "--branch=stable",
      lazyrepo, lazypath
    })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    spec = {
      -- import plugins specifications from ./lua/plugins/
      { import = "plugins" },
    },
    change_detection = {
      notify = false,
    },
    checker = {
      enabled = true,
      notify = false,
    },
    install = {
      colorscheme = {"gruvbox"},
    }
  })

  -- Some settings to reorganize.
  --[[
opt.updatetime = 1000
opt.shortmess = opt.shortmess .. 'FcI'
--]]
end
