return {
  { "folke/lazy.nvim",             version = "*" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = require("config.dashboard"),
      picker = {
        enabled = true,
        projects = {
          patterns = { ".git", "cargo.toml", "pyproject.toml", "Makefile", "README.md" },
        }
      },
      explorer = { enabled = true },
      input = { enabled = true },
      indent = { enabled = true },
      scroll = { enabled = true },
      scope = { enabled = true },
      words = { enabled = true },
      notifier = { enabled = true },
      toggle = { enabled = true },
      statuscolumn = { enabled = true },
    },
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      if Nv0.has_plugin("noice.nvim") then
        vim.notify = notify
      end
      Nv0.toggle.setup()
    end,
  },
  { "nvim-lua/plenary.nvim", },
  { "nvim-tree/nvim-web-devicons", }
}
