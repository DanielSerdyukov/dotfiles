local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "folke/neodev.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
}

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if has_cmp then
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      cmp_nvim_lsp.default_capabilities() or {}
    )
  end

  return vim.deepcopy(capabilities)
end

-- function M.on_attach(client, bufnr)
--   -- local opts = { noremap = true, silent = true }
--   -- local keymap = vim.api.nvim_buf_set_keymap
-- end

function M.config()
  local icons = require("user.icons")

  vim.diagnostic.config({
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
      },
    },
    -- virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    -- float = {
    --   focusable = true,
    --   style = "minimal",
    --   border = "rounded",
    --   source = "always",
    --   header = "",
    --   prefix = "",
    -- },
  })

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  require("user.bootstrap")
  require("mason").setup()

  local function setup(server)
    local options = {
      capabilities = M.common_capabilities(),
      handlers = {
        ["experimental/serverStatus"] = function(_, result, ctx)
          if result.health == "ok" and result.quiescent then
            vim.api.nvim_exec_autocmds("User", {
              pattern = "LspReady",
              buf = ctx.bufnr,
              data = {
                client_id = ctx.client_id,
              },
            })
          end
        end
      },
    }

    local has_settings, settings = pcall(require, "lsp."..server)

    if has_settings and settings.setup then
      settings.setup(vim.deepcopy(options))
    else
      require("lspconfig")[server].setup(options)
    end
  end

  require("mason-lspconfig").setup {
    ensure_installed = LSP_SERVERS,
    handlers = { setup }
  }
end

return M