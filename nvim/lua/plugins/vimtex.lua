return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<localLeader>l"] = { name = "+vimtex" },
      },
    },
  },

  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      local g = vim.g -- for conciseness
      -- disable `K` as it conflicts with LSP hover
      g.vimtex_mappings_disable = { ["n"]   = { "K" } }
      g.vimtex_view_method                  = 'skim'
      -- g.vimtex_view_method                  = 'sioyek'
      g.vimtex_callback_progpath            = '/opt/homebrew/bin/nvim'
      g.vimtex_fold_enabled                 = 0
      g.vimtex_indent_enabled               = 1
      g.vimtex_indent_delims                = {
        open = {},
        close = {},
        close_indented = 0,
        include_modified_math = 0
      }
      g.vimtex_syntax_enabled               = 1
      g.vimtex_syntax_conceal_disable       = 1
      g.tex_indent_items                    = 0
      g.tex_no_error                        = 1
      g.vimtex_mappings_prefix              = '<localleader>'

      g.vimtex_indent_ignored_envs = {
        'document',
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
        "proof"
      }

      g.vimtex_toc_config = {
        fold_enable = 0,
        fold_level_start = -1,
        hide_line_numbers = 1,
        hotkeys = "abcdeilmnopuvxyz",
        hotkeys_enabled = 0,
        hotkeys_leader = ";",
        indent_levels = 0,
        layer_keys = {
          content = "C",
          include = "I",
          label = "L",
          todo = "T"
        },
        layer_status = {
          content = 1,
          include = 1,
          label = 1,
          todo = 1
        },
        mode = 1,
        name = "Table of contents (VimTeX)",
        refresh_always = 1,
        resize = 0,
        show_help = 1,
        show_numbers = 1,
        -- split_pos = "vert leftabove",
        split_pos = "leftabove",
        split_width = 50,
        tocdepth = 3,
        todo_sorted = 1
      }

    end,
  },

  -- Correctly setup lspconfig for LaTeX
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {
          keys = {
            {
              "<leader>K", "<plug>(vimtex-doc-package)",
              desc = "Vimtex Docs",
              silent = true
            },
          },
        },
      },
    },
  },
}
