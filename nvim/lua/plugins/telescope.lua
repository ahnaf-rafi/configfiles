return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-bibtex.nvim",
    "nvim-telescope/telescope-file-browser.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.load_extension("fzf")
    telescope.load_extension("bibtex")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.move_selection_next,
            -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        bibtex = {
          -- Depth for the *.bib file
          depth = 1,
          -- Custom format for citation label
          custom_formats = {},
          -- Format to use for citation label.
          -- Try to match the filetype by default, or use 'plain'
          format = '',
          -- Path to global bibliographies (placed outside of the project)
          global_files = "~/Dropbox/research/bibliography.bib",
          -- Define the search keys to use in the picker
          search_keys = { 'author', 'year', 'title' },
          -- Template for the formatted citation
          citation_format = '{{author}} ({{year}}), {{title}}.',
          -- Only use initials for the authors first name
          citation_trim_firstname = true,
          -- Max number of authors to write in the formatted citation
          -- following authors will be replaced by "et al."
          citation_max_auth = 2,
          -- Context awareness disabled by default
          context = false,
          -- Fallback to global/directory .bib files if context not found
          -- This setting has no effect if context = false
          context_fallback = true,
          -- Wrapping in the preview window is disabled by default
          wrap = false,
        },
      },

      file_browser = {
        theme = "ivy",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
      },
    })

    require("telescope").load_extension("file_browser")

    -- set keymaps
    local keymap = vim.keymap.set
    local opts = {silent = true, noremap = true}

    -- Files
    opts.desc = "Fuzzy find files in cwd"
    -- open file_browser with the path of the current buffer
    keymap(
      "n", "<leader>ff",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", opts
    )

    keymap(
      "n", "<leader><leader>",
      "<cmd>Telescope find_files<cr>", opts
    )

    opts.desc = "Fuzzy find recent files"
    keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", opts)

    -- Buffers
    opts.desc = "Fuzzy find open buffers"
    keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>", opts)

    -- Grep
    opts.desc = "Find string in cwd"
    keymap("n", "<leader>sd", "<cmd>Telescope live_grep<cr>", opts)

    opts.desc = "Find string under cursor in cwd"
    keymap("n", "<leader>ss", "<cmd>Telescope grep_string<cr>", opts)

    -- Spelling
    opts.desc = "Spelling suggestions"
    keymap('n', 'z=', ':<c-u>Telescope spell_suggest<cr>', opts)
  end
}
