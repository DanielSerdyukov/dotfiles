local M = {
  "SmiteshP/nvim-navic",
  lazy = true
}

function M.config()
  local navic = require("nvim-navic")

  navic.setup {
    icons = Zen.icons.kind,
    depth_limit = 5,
    highlight = true,
  }

  require("zen.utils.lsp").on_attach(function(client, buffer)
    if client.supports_method("textDocument/documentSymbol") then
      navic.attach(client, buffer)
    end
  end)
end

return M
