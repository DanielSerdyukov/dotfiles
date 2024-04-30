local M = {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
}

function M.config()
  require("project_nvim").setup {
    patterns = { ".git", "Cargo.toml", "pyproject.toml", "README.md" },
  }
end

return M
