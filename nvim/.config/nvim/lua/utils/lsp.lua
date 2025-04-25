local M = {}

M.on_init = function()
  M.on_attach(function(client, buffer)
    if not client:supports_method("textDocument/willSaveWaitUntil") then
      if client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("lsp", { clear = false }),
          buffer = buffer,
          callback = function()
            M.format(client, buffer)
          end,
        })
      end
    end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
    end

    if client:supports_method("textDocument/codeLens") then
      if vim.g.codelens == nil or vim.g.codelens then
        vim.lsp.codelens.refresh()
      end
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lsp", { clear = false }),
        buffer = buffer,
        callback = function()
          if vim.g.codelens == nil or vim.g.codelens then
            vim.lsp.codelens.refresh()
          end
        end,
      })
    end
  end)
end

---@param fn fun(client, buffer)
---@param name? string
M.on_attach = function(fn, name)
  return vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return fn(client, buffer)
      end
    end,
  })
end

M.format = function(client, buffer)
  if vim.g.autoformat == nil or vim.g.autoformat then
    local has_conform, conform = pcall(require, "conform")
    if has_conform then
      conform.format({ bufnr = buffer, async = false, lsp_format = "fallback" })
    else
      vim.lsp.buf.format({ bufnr = buffer, id = client.id, timeout_ms = 500 })
    end
  end
end

M.formatexpr = function()
  if Nv0.has_plugin("conform.nvim") then
    return require("conform").formatexpr()
  else
    return vim.lsp.formatexpr({ timeout_ms = 500 })
  end
end

return M
