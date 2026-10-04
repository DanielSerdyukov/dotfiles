---@type ExzoPluginSpec
return {
  src = "https://github.com/catppuccin/nvim",
  name = "catppuccin",
  setup = function()
    require("catppuccin").setup({})
  end,
}
