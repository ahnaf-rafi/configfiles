return {
  "lervag/vimtex",
  lazy = false,
  init = function ()
    vim.g.vimtex_mappings_prefix = '<localleader>'
    -- Disable `K` as it conflicts with LSP hover.
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }

    vim.g.vimtex_indent_ignored_envs = {
      "document",
      "frame",
      "theorem",
      "thm",
      "corollary",
      "cor",
      "lemma",
      "lem",
      "definition",
      "def",
      "assumption",
      "asm",
      "remark",
      "rem",
      "example",
      "eg",
      "notation",
      "note",
      "problem",
      "solution",
      "proof"
    }

    -- Don't indent delimiters.
    vim.g.vimtex_indent_delims = {
      open = {},
      close = {},
      close_indented = 0,
      include_modified_math = 0
    }

    -- TODO: make this OS-agnostic.
    vim.g.vimtex_view_method = 'zathura_simple'

    -- -- vim.g.vimtex_view_method = 'skim'
    -- -- vim.g.vimtex_callback_progpath = '/opt/homebrew/bin/nvim'
    -- -- vim.g.vimtex_callback_progpath = exepath(v:progname)
    -- vim.g.vimtex_fold_enabled = 0
    -- vim.g.vimtex_indent_enabled = 1
    -- vim.g.vimtex_syntax_enabled = 1
    -- vim.g.vimtex_syntax_conceal_disable = 1
    -- vim.g.tex_indent_items = 0
    -- vim.g.tex_no_error = 1
    --
    -- vim.g.vimtex_toc_config = {
    --   fold_enable = 0,
    --   fold_level_start = -1,
    --   hide_line_numbers = 1,
    --   hotkeys = "abcdeilmnopuvxyz",
    --   hotkeys_enabled = 0,
    --   hotkeys_leader = ";",
    --   indent_levels = 0,
    --   layer_keys = {
    --     content = "C",
    --     include = "I",
    --     label = "L",
    --     todo = "T"
    --   },
    --   layer_status = {
    --     content = 1,
    --     include = 1,
    --     label = 1,
    --     todo = 1
    --   },
    --   mode = 1,
    --   name = "Table of contents (VimTeX)",
    --   refresh_always = 1,
    --   resize = 0,
    --   show_help = 1,
    --   show_numbers = 1,
    --   -- split_pos = "vert leftabove",
    --   split_pos = "leftabove",
    --   split_width = 50,
    --   tocdepth = 3,
    --   todo_sorted = 1
    -- }
  end,
}
