local M = {}

function M.define(autocmds, options)
  local utils = require("zen.utils")
  for _, entry in ipairs(autocmds) do
    local event = entry[1]
    local opts = entry[2]
    if type(opts.group) == "string" and opts.group ~= "" then
      local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
      if not exists then
        vim.api.nvim_create_augroup(opts.group, {})
      end
    end
    vim.api.nvim_create_autocmd(event, utils.merge(opts, options or {}))
  end
end

return M
