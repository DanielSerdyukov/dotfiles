return {
  {
    { "TextYankPost" },
    {
      group = "_general_settings",
      pattern = "*",
      desc = "Highlight text on yank",
      callback = function()
        vim.highlight.on_yank { higroup = "Search", timeout = 100 }
      end,
    },
  },
  {
    { "FileType" },
    {
      group = "_buffer_mappings",
      pattern = {
        "qf",
        "help",
        "man",
        "floaterm",
        "lspinfo",
        "lir",
        "lsp-installer",
        "null-ls-info",
        "tsplayground",
        "DressingSelect",
        "Jaq",
      },
      callback = function()
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
        vim.opt_local.buflisted = false
      end,
    }
  },
  {
    { "FileType" },
    {
      group = "_filetype_settings",
      pattern = "alpha",
      callback = function()
        vim.cmd [[ set nobuflisted ]]
      end,
    },
  },
}
