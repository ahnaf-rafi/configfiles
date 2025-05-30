return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",            -- Source for text in buffer
    "hrsh7th/cmp-path",              -- Source for file system paths
    "hrsh7th/cmp-omni",              -- Source for file system paths
    "R-nvim/cmp-r",                  -- Source for R completions via R.nvim
    "L3MON4D3/LuaSnip",              -- Snippet engine
    "saadparwaiz1/cmp_luasnip",      -- For autocompletion
    "rafamadriz/friendly-snippets",  -- Useful snippets
    "onsails/lspkind.nvim"           -- VS-Code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      -- Configure how nvim-cmp interacts with snippet engine
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Show completion suggestions
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Close completion window
        ["<C-g>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),

      -- Sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },  -- Lsp
        { name = "cmp_r" },     -- cmp_r backend for R.nvim
        { name = "luasnip" },   -- Snippets
        { name = "buffer" },    -- Text within current buffer
        { name = "path" },      -- File system paths
      }),
      -- Configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
    require("cmp_r").setup({})
  end,
}
