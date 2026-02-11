vim.lsp.enable(
  { 'basedpyright', 'julials', 'ltex_plus', 'lua_ls',
  -- 'texlab',
  'tinymist' }
)

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  jump = {
    float = true,
  },
})

vim.keymap.set("n", "<C-w>d", function()
  vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Show cursor diagnostics" })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- if client ~= nil and client:supports_method('textDocument/completion') then
    --   vim.lsp.completion.enable(
    --     true, client.id, ev.buf, { autotrigger = true }
    --   )
    -- end

    ------------------
    -- Set keybinds --
    ------------------

    local keyopts = { noremap = true, silent = true, buffer = ev.buf}
    local keymap = vim.keymap.set
    local FzfLua = require("fzf-lua")

    -- Show documentation under cursor.
    keyopts.desc = "Show documentation under cursor"
    keymap("n", "K", vim.lsp.buf.hover, keyopts)

    -- Go to declaration.
    keyopts.desc = "Go to declaration"
    keymap("n", "gD", vim.lsp.buf.declaration, keyopts)

    -- Smart rename
    keyopts.desc = "Smart rename"
    keymap("n", "grn", vim.lsp.buf.rename, keyopts)

    -- Show lsp definitions.
    keyopts.desc = "Show LSP definitions"
    keymap("n", "gd", FzfLua.lsp_definitions, keyopts)

    -- Show definition, references.
    keyopts.desc = "Show LSP references"
    keymap("n", "grr", FzfLua.lsp_references, keyopts)

    --  -- Show diagnostics for file
    --  keyopts.desc = "Show buffer diagnostics"
    --  keymap("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<cr>", keyopts)

    --  -- keymapping to restart lsp if necessary
    --  keyopts.desc = "Restart LSP"
    --  keymap("n", "<leader>clr", ":LspRestart<cr>", keyopts)
  end
})
