return {
  "nvim-treesitter/nvim-treesitter",
  event = { "VeryLazy" },
  build = ":TSUpdate",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  lazy = vim.fn.argc(-1) == 0,
  version = false,
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  config = function()
    local ensure_installed = Nv0.extend({
      "lua",
      "markdown",
      "markdown_inline"
    }, Nv0.config.ts_parsers)

    require("nvim-treesitter.configs").setup {
      ensure_installed = ensure_installed,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    }
  end
}
