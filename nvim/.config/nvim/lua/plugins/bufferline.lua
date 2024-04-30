local M = {
  "akinsho/bufferline.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" }
  },
  event = "VeryLazy",
}

function M.config()
  require("bufferline").setup {
    options = {
        numbers = "none",
        -- tab_size = 20,
        diagnostics = false,      -- | "nvim_lsp" | "coc",
        show_close_icon = false,
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
    }
  }
end

return M