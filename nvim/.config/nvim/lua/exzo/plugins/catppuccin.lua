---@type ExzoPluginSpec
return {
  src = require("exzo").gh("catppuccin/nvim"),
  name = "catppuccin",
  setup = function()
    require("catppuccin").setup({})
  end,
}
