local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "folke/neodev.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
}

function M.default_capabilities()
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  return require("zen.utils").merge(
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
  )
end

function M.config()
  vim.diagnostic.config({
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = function(diagnostic)
        local icons = Zen.icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end,
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = Zen.icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = Zen.icons.diagnostics.Warn,
        [vim.diagnostic.severity.HINT] = Zen.icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = Zen.icons.diagnostics.Info,
      },
    },
  })

  require("mason").setup()

  local ensure_installed = {}
  local lsp_servers = {}

  for server_name, custom_config in pairs(Zen.lsp_servers) do
    if type(custom_config) == "function" then
      ensure_installed[#ensure_installed + 1] = server_name
      lsp_servers[server_name] = custom_config
    elseif type(custom_config) == "string" then
      ensure_installed[#ensure_installed + 1] = custom_config
      local has_default_config, default_config = pcall(require, "zen.lsp." .. custom_config)
      if has_default_config then
        lsp_servers[custom_config] = default_config
      end
    end
  end

  local function setup(server)
    local options = {
      capabilities = M.default_capabilities(),
    }

    if lsp_servers[server] then
      lsp_servers[server](vim.deepcopy(options))
    else
      require("lspconfig")[server].setup(options)
    end
  end

  require("mason-lspconfig").setup {
    ensure_installed = ensure_installed,
    handlers = { setup },
  }

  local lsp = require("zen.utils.lsp")

  lsp.on_attach(function(client, buffer)
    if client.supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true)
    end

    -- if client.supports_method("textDocument/codeLens") then
    --   vim.lsp.codelens.refresh()
    --   vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    --     buffer = buffer,
    --     callback = vim.lsp.codelens.refresh,
    --   })
    -- end
  end)

  lsp.on_attach(function(client, buffer)
    local utils = require("zen.utils.keymaps")
    local keymaps = require("zen.config.keymaps")
    utils.set(keymaps.lsp, { buffer = buffer })
  end)
end

return M
