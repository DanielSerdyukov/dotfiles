local M = {}

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local buffer = event.buf ---@type number
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

return M
