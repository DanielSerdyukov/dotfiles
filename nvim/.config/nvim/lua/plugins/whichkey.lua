return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    }
  },
  opts = {
    preset = "modern",
    spec = {
      mode = { "n", "v" },
      { "<leader>c", group = "code", icon = { icon = "󰊕 " } },
      { "<leader>f", group = "file/find", icon = { icon = " " } },
      { "<leader>g", group = "git", icon = { icon = " " } },
      { "<leader>q", group = "quit/session", icon = { icon = " " } },
      { "<leader>s", group = "search", icon = { icon = " " } },
      { "<leader>u", group = "ui", icon = { icon = "󰙵 " } },
      { "<leader>h", group = "history", icon = { icon = " " } },
      { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 " } },
      { "<leader>t", group = "toggle", icon = { icon = " " } },
      {
        "<leader>b",
        group = "buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
    }
  }
}
