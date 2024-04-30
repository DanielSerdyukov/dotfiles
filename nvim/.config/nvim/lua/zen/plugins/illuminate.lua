local M = {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
}

function M.config()
  require("illuminate").configure {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp", "treesitter" },
    },
    filetypes_denylist = {
      "mason",
      "harpoon",
      "DressingInput",
      "fugitive",
      "alpha",
      "NvimTree",
      "lazy",
      "DressingSelect",
      "TelescopePrompt",
    },
  }
end

return M
