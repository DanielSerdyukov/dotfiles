local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  require("ibl").setup {
    exclude = {
      buftypes = {
        "nofile",
        "prompt",
        "quickfix",
        "terminal",
        "telescope",
      },
      filetypes = {
        "alpha",
        "help",
        "lazy",
        "mason",
        "NvimTree",
        "TelescopePrompt",
      },
    },
    indent = {
      char = "│",
    },
    scope = {
      enabled = true,
      show_start = false,
    },
  }
end

return M
