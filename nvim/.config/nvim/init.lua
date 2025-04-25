require("config").setup {
  -- https://lazy.folke.io/spec#spec-setup
  colorscheme = {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        integrations = {
          blink_cmp = true,
          which_key = true,
          snacks = { enabled = true }
        }
      })
      vim.cmd("colorscheme catppuccin-mocha")
    end,
    name = "catppuccin"
  },
  -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
  ts_parsers = {
    "bash",
    "rust",
    "python",
    "yaml",
    "toml",
    "json",
    "csv",
    "regex",
    "ledger",
    "gitcommit",
    "gitignore"
  },
  -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
  lsp_servers = {
    "rust_analyzer",
    -- ["rust_analyzer"] = {}
    -- ["rust_analyzer"] = function()
    -- end
  },
  lsp_keymaps = {
    { "<leader>cs", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols", },
    { "<leader>cS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols", },
    { "<leader>cR", function() Snacks.picker.lsp_references() end,        desc = "LSP References",        nowait = true, },
    { "<leader>cd", function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition", },
    { "<leader>cD", function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration", },
    { "<leader>ci", function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
    { "<leader>cy", function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
    { "<leader>xa", function() vim.lsp.buf.code_action() end,             desc = "Code Actions" },
    { "<leader>xd", function() Snacks.picker.diagnostics() end,           desc = "Goto Diagnostics" },
    { "<leader>xq", function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
    { "<leader>cr", function() vim.lsp.buf.rename() end,                  desc = "Rename", },
  },
  formatters = {
    -- lua = { "stylua" }
  },
  keymaps = {
    { "<leader>fs", function() Snacks.picker.smart() end,           desc = "Smart Search", },
    { "<leader>ff", function() Snacks.picker.files() end,           desc = "Find Files", },
    { "<leader>fr", function() Snacks.picker.recent() end,          desc = "Recent Files", },
    { "<leader>fe", function() Snacks.picker.explorer() end,        desc = "File Explorer", },
    { "<leader>fn", function() Nv0.new_file() end,                  desc = "New File", },
    -- search
    { "<leader>sg", function() Snacks.picker.grep() end,            desc = "Grep", },
    -- buffers
    { "<leader>bf", function() Snacks.picker.buffers() end,         desc = "Find Buffers", },
    { "<leader>bd", function() Snacks.bufdelete() end,              desc = "Close Buffer", },
    { "<leader>bo", function() Snacks.bufdelete.other() end,        desc = "Delete Other Buffers", },
    -- history
    { "<leader>h:", function() Snacks.picker.command_history() end, desc = "Command History", },
    { "<leader>hn", function() Snacks.picker.notifications() end,   desc = "Notifications", },
    { "<leader>hu", function() Snacks.picker.undo() end,            desc = "Undo History", },
    -- quit/sessions
    { "<leader>qq", "<cmd>confirm qa<cr>",                          desc = "Quit", },
    -- editor
    { "<M-s>",      "<cmd>w<cr><esc>",                              desc = "Save",                 mode = { "i", "x", "n", "s" } },
    { "<M-z>",      "<cmd>undo<cr>",                                desc = "Undo",                 mode = { "i", "n" } },
    { "<S-M-z>",    "<cmd>redo<cr>",                                desc = "Redo",                 mode = { "i", "n" } },
    { "<M-j>",      "<cmd>:m .+1<cr>",                              desc = "Move Down",            mode = { "i", "n" } },
    { "<M-k>",      "<cmd>:m .-2<cr>",                              desc = "Move Up",              mode = { "i", "n" } },
    { "<M-d>",      "yyP",                                          desc = "Duplicate line", },
  }
}
