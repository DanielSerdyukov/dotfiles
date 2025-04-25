return {
  "SmiteshP/nvim-navic",
  event = "VeryLazy",
  init = function()
    vim.g.navic_silence = true
    Nv0.lsp.on_attach(function(client, buffer)
      if client:supports_method("textDocument/documentSymbol") then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
  opts = {
    separator = "  ",
    highlight = true,
    depth_limit = 5,
    icons = Nv0.icons.kinds,
    lazy_update_context = true,
  }
}
