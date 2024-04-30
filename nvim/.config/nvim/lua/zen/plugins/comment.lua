local M = {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" }
}

function M.config()
  require('Comment').setup()
end

return M
