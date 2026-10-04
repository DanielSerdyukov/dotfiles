local M = {}

function M.setup(opts)
  local config = require("exzo.config").setup(opts)

  -- core vim.opt must be set before plugins loads
  require("exzo.config.options").setup(config)

  require("exzo.plugins").setup(config)

  -- core autocmds, keymaps, and native LSP
  require("exzo.config.autocmds").setup(config)
  -- require("exzo.config.keymaps").setup(config)
  -- require("exzo.config.lsp").setup(config)

  if config.colorscheme then
    local ok = pcall(vim.cmd.colorscheme, config.colorscheme)
    if not ok then
      pcall(vim.cmd.colorscheme, "habamax")
    end
  end
end

return M
