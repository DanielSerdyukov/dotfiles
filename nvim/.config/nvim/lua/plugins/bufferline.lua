return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      close_command = function(n) Snacks.bufdelete(n) end,
      offsets = {
        { filetype = "snacks_layout_box" },
      },
    }
  }
}
