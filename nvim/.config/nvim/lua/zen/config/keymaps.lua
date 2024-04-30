return {
  global = {
    { "n",               "<D-n>",      ":enew<cr>",    "New Buffer" },
    { "n",               "<D-w>",      ":bdelete<cr>", "Close Buffer" },
    { "n",               "<D-z>",      ":undo<cr>",    "Undo" },
    { "n",               "<S-D-z>",    ":redo<cr>",    "Redo" },
    { { "n", "i", "v" }, "<D-s>",      "<esc>:w<cr>",  "Save File" },
    { "n",               "<leader>qq", ":qa<cr>",      "Quit All" },
    { "n",               "<TAB>",      ">>",           "Indent right" },
    { "n",               "<S-TAB>",    "<<",           "Indent left" },
    { "v",               "<TAB>",      ">gv",          "Indent right" },
    { "v",               "<S-TAB>",    "<gv",          "Indent left" },
    { "n",               "<S-D-Down>", ":m .+1<cr>",   "Move down" },
    { "n",               "<S-D-Up>",   ":m .-2<cr>",   "Move up" },
    { "n",               "<D-/>",      "gcc",          "Line comment" },
    function()
      local ts = require("telescope.builtin")
      return {
        { "n", "<D-f>",      ts.current_buffer_fuzzy_find, "Search" },
        { "n", "<D-b>",      ts.buffers,                   "Buffers" },
        { "n", "<D-o>",      ts.find_files,                "Find Files" },
        { "n", "<D-e>",      ts.oldfiles,                  "Recent Files" },
        { "n", "<S-D-f>",    ts.live_grep,                 "Search in files" },
        { "n", "<leader>gb", ts.git_branches,              "Git Branches" },
        { "n", "<leader>gc", ts.git_commits,               "Git Commits" },
        { "n", "<leader>gs", ts.git_status,                "Git Status" },
      }
    end
  },
  lsp = {
    function()
      local ts = require("telescope.builtin")

      local function lsp_definitions()
        ts.lsp_definitions({ reuse_win = true })
      end

      return {
        { "n", "K",          vim.lsp.buf.hover,          "Help" },
        { "n", "<D-k>",      vim.lsp.buf.signature_help, "Signature Help" },
        { "n", "<leader>ca", vim.lsp.buf.code_action,    "Code Action" },
        { "n", "<leader>cl", vim.lsp.codelens.run,       "Codelens" },
        { "n", "<leader>cd", lsp_definitions,            "Code Definition" },
        { "n", "<leader>cr", ts.lsp_references,          "Code References" },
        { "n", "<leader>cs", ts.lsp_document_symbols,    "Document Symbols" },
        { "n", "<leader>cS", ts.lsp_workspace_symbols,   "Workspace Symbols" },
        { "n", "<leader>xd", ts.diagnostics,             "Diagnostics" },
        { "n", "<leader>xf", ts.quickfix,                "Quickfix" }
      }
    end
  },
}
