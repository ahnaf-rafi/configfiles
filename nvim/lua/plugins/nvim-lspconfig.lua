return {

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "julials",
          "nil_ls",
        },
      })

      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap.set -- for conciseness

      local opts = { noremap = true, silent = true }
      local on_attach = function(_, bufnr)
        opts.buffer = bufnr

        -- set keybinds
        -- Show definition, references
        opts.desc = "Show LSP references"
        keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

        -- Go to declaration
        opts.desc = "Go to declaration"
        keymap("n", "gD", vim.lsp.buf.declaration, opts)

        -- Show lsp definitions
        opts.desc = "Show LSP definitions"
        keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        -- Show lsp implementations
        opts.desc = "Show LSP implementations"
        keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        -- Show lsp type definitions
        opts.desc = "Show LSP type definitions"
        keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- See available code actions, in visual mode will apply to selection
        opts.desc = "See available code actions"
        keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Smart rename
        opts.desc = "Smart rename"
        keymap("n", "gR", vim.lsp.buf.rename, opts)
        -- keymap("n", "<leader>cr", vim.lsp.buf.rename, opts)

        -- Show  diagnostics for file
        opts.desc = "Show buffer diagnostics"
        keymap("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        -- Show diagnostics for line
        opts.desc = "Show line diagnostics"
        keymap("n", "<leader>cd", vim.diagnostic.open_float, opts)

        -- Jump to previous diagnostic in buffer
        opts.desc = "Go to previous diagnostic"
        keymap(
          "n", "[d",
          function ()
            vim.diagnostic.jump({count=-1, float=true})
          end,
          opts
        )

        -- Jump to next diagnostic in buffer
        opts.desc = "Go to next diagnostic"
        keymap(
          "n", "]d",
          function ()
            vim.diagnostic.jump({count=1, float=true})
          end,
          opts
        )

        -- Show documentation for what is under cursor
        opts.desc = "Show documentation for what is under cursor"
        keymap("n", "K", vim.lsp.buf.hover, opts)

        -- Mapping to restart lsp if necessary
        opts.desc = "Restart LSP"
        keymap("n", "<leader>clr", ":LspRestart<CR>", opts)
      end
      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- configure julia server
      lspconfig.julials.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

      -- configure tex server
      lspconfig.texlab.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

      -- configure nil server
      lspconfig.nil_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

      -- configure lua server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
              disable = { 'missing-fields' },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if not (vim.uv or vim.loop).fs_stat(path .. '/.luarc.json') and not (vim.uv or vim.loop).fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                  }
                }
              }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end
      })
    end
  }
}
