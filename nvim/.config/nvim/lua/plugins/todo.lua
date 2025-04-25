return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
  },
  enabled = false
}
