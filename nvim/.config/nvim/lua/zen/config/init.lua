require("zen.config.options")

Zen = {}
Zen.icons = require("zen.config.icons")
Zen.lsp_servers = {}

function Zen.setup(params)
  for name, server in pairs(params.lsp_servers or {}) do
    Zen.lsp_servers[name] = server
  end
end
