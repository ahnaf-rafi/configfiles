vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local keyopts = { noremap = true, silent = true, buffer = ev.buf}
    local map = vim.keymap.set

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true
      })
    end

    ------------------
    -- Set keybinds --
    ------------------

    -- Show definition, references
    -- keyopts.desc = "Show LSP references"
    -- map("n", "gr", "<cmd>Telescope lsp_references<CR>", keyopts)

    -- Go to declaration
    keyopts.desc = "Go to declaration"
    map("n", "gD", vim.lsp.buf.declaration, keyopts)

    -- Show lsp definitions
    -- keyopts.desc = "Show LSP definitions"
    -- map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", keyopts)

    -- Show lsp implementations
    -- keyopts.desc = "Show LSP implementations"
    -- map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", keyopts)

    -- Show lsp type definitions
    -- keyopts.desc = "Show LSP type definitions"
    -- map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", keyopts)

    -- See available code actions, in visual mode will apply to selection
    keyopts.desc = "See available code actions"
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, keyopts)

    -- Smart rename
    keyopts.desc = "Smart rename"
    map("n", "gR", vim.lsp.buf.rename, keyopts)
    -- map("n", "<leader>cr", vim.lsp.buf.rename, keyopts)

    -- Show diagnostics for file
    -- keyopts.desc = "Show buffer diagnostics"
    -- map("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", keyopts)

    -- Show diagnostics for line
    keyopts.desc = "Show line diagnostics"
    map("n", "<leader>cd", vim.diagnostic.open_float, keyopts)

    -- Jump to previous diagnostic in buffer
    keyopts.desc = "Go to previous diagnostic"
    map(
      "n", "[d",
      function ()
        vim.diagnostic.jump({count=-1, float=true})
      end,
      keyopts
    )

    -- Jump to next diagnostic in buffer
    keyopts.desc = "Go to next diagnostic"
    map(
      "n", "]d",
      function ()
        vim.diagnostic.jump({count=1, float=true})
      end,
      keyopts
    )

    -- Show documentation for what is under cursor
    keyopts.desc = "Show documentation for what is under cursor"
    map("n", "K", vim.lsp.buf.hover, keyopts)

    -- Mapping to restart lsp if necessary
    keyopts.desc = "Restart LSP"
    map("n", "<leader>clr", ":LspRestart<CR>", keyopts)
  end
})

vim.lsp.enable({ "nixd", "lua_ls", "texlab", "tinymist", "julials"})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})

vim.lsp.config("nixd", {
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" }, -- or nixfmt or nixpkgs-fmt
      },
      -- options = {
      --   nixos = {
      --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").nixosConfigurations.CONFIGNAME.options',
      --   },
      --   home_manager = {
      --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
      --   },
      -- },
    },
  },
})

vim.lsp.config("tinymist", {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "disable"
  },
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<leader>tp", function()
      client:exec_cmd({
        title = "pin",
        command = "tinymist.pinMain",
        arguments = { vim.api.nvim_buf_get_name(0) },
      }, { bufnr = bufnr })
    end, { desc = "[T]inymist [P]in", noremap = true })

    vim.keymap.set("n", "<leader>tu", function()
      client:exec_cmd({
        title = "unpin",
        command = "tinymist.pinMain",
        arguments = { vim.v.null },
      }, { bufnr = bufnr })
    end, { desc = "[T]inymist [U]npin", noremap = true })
  end,
})
