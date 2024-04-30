local M = {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
}

function M.config()
  require("illuminate").configure {
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