return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim",        words = { "Snacks" } },
        },
      },
    }
  },
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = function(diagnostic)
          local icons = Nv0.icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end,
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = Nv0.icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = Nv0.icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = Nv0.icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = Nv0.icons.diagnostics.Info,
        },
      },
    },
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            telemetry = { enable = false },
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = 'Replace',
            },
            doc = {
              privateName = { '^_' },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              semicolon = 'Disable',
              arrayIndex = 'Disable',
            },
          }
        }
      }
    }
  },
  config = function(_, opts)
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    Nv0.lsp.on_attach(function(_, buffer)
      Nv0.keymaps.set(Nv0.config.lsp_keymaps, { buffer = buffer })
    end)

    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local has_blink, blink = pcall(require, "blink.cmp")
    local capabilities = Nv0.merge(
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    local default_opts = {
      capabilities = capabilities,
      on_init = Nv0.lsp.on_init,
      root_markers = { '.git' }
    }

    if vim.lsp.config then
      vim.lsp.config("*", default_opts)
    end

    local ensure_installed = {}
    local server_opts = {}
    local lsp_servers = Nv0.extend(
      opts.servers,
      Nv0.config.lsp_servers
    )

    for server_name, server_config in pairs(lsp_servers) do
      if type(server_config) == "function" then
        ensure_installed[#ensure_installed + 1] = server_name
        server_opts[server_name] = server_config()
      elseif type(server_config) == "table" then
        ensure_installed[#ensure_installed + 1] = server_name
        server_opts[server_name] = server_config
      elseif type(server_config) == "string" then
        ensure_installed[#ensure_installed + 1] = server_config
      end
    end

    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = ensure_installed,
      handlers = {
        function(server_name)
          if vim.lsp.config then
            vim.lsp.config(server_name, vim.deepcopy(server_opts[server_name] or {}))
            vim.lsp.enable(server_name)
          else
            local options = Nv0.merge(default_opts, server_opts[server_name] or {})
            require("lspconfig")[server_name].setup(options)
          end
        end
      }
    }
  end
}
