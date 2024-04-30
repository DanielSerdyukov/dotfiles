return function(options)
  local has_neodev, neodev = pcall(require, "neodev")
  if has_neodev then
    neodev.setup()
  end
  require("lspconfig").lua_ls.setup(options)
end