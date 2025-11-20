return {
  ------------------------------------------------------
  -- JSON schema 用
  ------------------------------------------------------
  {
    "b0o/schemastore.nvim",
  },

  ------------------------------------------------------
  -- Mason
  ------------------------------------------------------
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  ------------------------------------------------------
  -- LSP + mason-lspconfig + CMP
  ------------------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "b0o/schemastore.nvim",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local cmp = require("cmp")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = {
          "pyright",
          "lua_ls",
          "ts_ls",
          "jsonls",
          "marksman",
          "svelte",
          "yamlls",
          "html",
          "cssls",
        },
        automatic_installation = true,
      })

      ------------------------------------------------------
      -- LSP config
      ------------------------------------------------------
      vim.lsp.config("pyright", { capabilities = capabilities })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      vim.lsp.config("ts_ls", { capabilities = capabilities })

      vim.lsp.config("jsonls", {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config("marksman", { capabilities = capabilities })
      vim.lsp.config("svelte", { capabilities = capabilities })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            keyOrdering = false,
          },
        },
      })

      vim.lsp.config("html", { capabilities = capabilities })
      vim.lsp.config("cssls", { capabilities = capabilities })

      ------------------------------------------------------
      -- Enable all
      ------------------------------------------------------
      vim.lsp.enable("pyright")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("marksman")
      vim.lsp.enable("svelte")
      vim.lsp.enable("yamlls")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")

      ------------------------------------------------------
      -- nvim-cmp
      ------------------------------------------------------
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
