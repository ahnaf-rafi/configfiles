return {
	"L3MON4D3/LuaSnip",
	version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  event = "InsertEnter",
	build = "make install_jsregexp",
  config = function ()
    -- Yes, we're just executing a bunch of Vimscript, but this is the officially
    -- endorsed method; see https://github.com/L3MON4D3/LuaSnip#keymaps
    vim.cmd[[
    " press <Tab> to expand or jump in a snippet.
    " These can also be mapped separately via <Plug>luasnip-expand-snippet and
    " <Plug>luasnip-jump-next.
    imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>

    " Use Shift-Tab to jump backwards through snippets (that's what the -1 is for)
    inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
    snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

    " For changing choices in choiceNodes (not strictly necessary for a basic setup).
    imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
    smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

    "  Use Tab to expand and jump through snippets
    "imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    "smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

    "" Use Shift-Tab to jump backwards through snippets
    "imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    "smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    ]]
    -- Somewhere in your Neovim startup, e.g. init.lua
    require("luasnip").config.set_config({ -- Setting LuaSnip config
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    })

    -- loads vscode style snippets from friendly-snippets
    -- require("luasnip.loaders.from_vscode").lazy_load()

    require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})
  end
}
