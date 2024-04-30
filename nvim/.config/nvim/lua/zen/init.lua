if vim.fn.has('nvim-0.10') == 0 then
  error('Need Neovim v0.10+ run Zen!')
end

if vim.loader then
  vim.loader.enable()
end

require("zen.core")
