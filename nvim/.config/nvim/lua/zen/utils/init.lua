local M = {}

function M.merge(...)
  return vim.tbl_deep_extend("force", {}, ...)
end

M.lsp = require("zen.utils.lsp")
M.keymaps = require("zen.utils.keymaps")
M.autocmds = require("zen.utils.autocmds")

return M
