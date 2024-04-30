PLUGINS = {}
LSP_SERVERS = {}

function plugin(item)
  table.insert(PLUGINS, { import = item })
end

function lsp(server)
  table.insert(LSP_SERVERS, server)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "