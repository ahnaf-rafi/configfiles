return {
  "L3MON4D3/LuaSnip", 
  lazy = false,
  -- event = "InsertEnter",
  version = "v2.*",
  config = function ()
    local ls = require("luasnip")
    local keymap = vim.keymap.set
    local keyopts = { silent = true }
    ls.setup({
      enable_autosnippets = true,
      -- store_selection_keys = "<Tab>",
      store_selection_keys = "<C-k>",
    })

    require("luasnip.loaders.from_lua").lazy_load({
      paths = vim.fn.stdpath("config") .. "/snippets-luasnip/"
    })

    -- vim.cmd[[
    -- " press <Tab> to expand or jump in a snippet.
    -- " These can also be mapped separately via <Plug>luasnip-expand-snippet and
    -- " <Plug>luasnip-jump-next.
    -- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    -- snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>

    -- " Use Shift-Tab to jump backwards through snippets (that's what the -1 is for)
    -- inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
    -- snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

    -- " For changing choices in choiceNodes (not strictly necessary for a basic setup).
    -- imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
    -- smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

    -- " Use Tab to expand and jump through snippets
    -- "imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    -- "smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

    -- "" Use Shift-Tab to jump backwards through snippets
    -- "imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    -- "smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    -- ]]

    keymap({"i"}, "<C-k>", function() ls.expand() end, keyopts)
    keymap({"i", "s"}, "<C-l>", function() ls.jump( 1) end, keyopts)
    keymap({"i", "s"}, "<C-j>", function() ls.jump(-1) end, keyopts)

    keymap({"i", "s"}, "<C-e>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, keyopts)
  end
}
