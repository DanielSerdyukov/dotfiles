local function plugin(name)
  return require("zen.plugins." .. name)
end

return {
  plugin("nightfox"),
  -- plugin("gruvbox"),
  plugin("treesitter"),
  plugin("lualine"),
  plugin("bufferline"),
  plugin("lsp"),
  plugin("cmp"),
  plugin("ibl"),
  plugin("navic"),
  plugin("autopairs"),
  plugin("comment"),
  plugin("illuminate"),
  plugin("project"),
  plugin("telescope"),
  plugin("noice"),
  plugin("whichkey"),
  plugin("alpha"),
}
