local M = {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  -- event = "VeryLazy",
}

function M.config()
  require("nvim-tree").setup {
    view = {
      width = 50,
    },
    filters = {
      custom = {
        "^.git$"
      }
    },
    update_focused_file = {
      enable = true
    }
  }
end

return M
