local M = {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  lazy = false,
}

function M.config()
  require('nightfox').setup {
    options = {
      transparent = true
    }
  }
  vim.cmd("colorscheme carbonfox")
end

return M
