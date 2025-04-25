return {
  "saghen/blink.cmp",
  dependencies = {
    { "L3MON4D3/LuaSnip",            version = "v2.*" },
    { "rafamadriz/friendly-snippets" }
  },
  version = '1.*',
  event = "InsertEnter",
  opts_extend = { "sources.default" },
  opts = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    return {
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = {
        menu = {
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label",     "label_description", gap = 1 },
              { "kind_icon", "kind",              gap = 1 }
            },
          }
        },
        ghost_text = { enabled = true },
      },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { "lsp", "snippets", "buffer", "path" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true }
    }
  end
}
