local M = {
  default = {
    -- Buffer
    { "n", "<M-n>", "<cmd>enew<cr>",  "New Buffer" },
    { "n", "<M-l>", "<cmd>bnext<cr>", "Next Buffer" },
    { "n", "<M-h>", "<cmd>bprevious<cr>", "Previous Buffer" },
    { "n", "<M-w>", "<cmd>bdelete<cr>", "Close Buffer" },
    -- Telescope
    { "n", "<M-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find" },
    { "n", "<M-o>", "<cmd>Telescope find_files<cr>", "Find Files" },
    { "n", "<M-e>", "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    { "n", "<S-M-f>", "<cmd>Telescope live_grep<cr>", "Search in files" },
  },
  lsp = {
    { "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  },
}

local function keymap(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local function setup_keys(keys)
  local opts = { noremap = true, silent = true }

  keymap("n", "<Space>", "", opts)

  local has_wk, wk = pcall(require, "which-key")

  for _, v in ipairs(keys) do
    local mode, lhs, rhs, desc = unpack(v)
    keymap(mode, lhs, rhs, vim.tbl_deep_extend("force", { desc = desc }, opts))

    if has_wk then
      wk.register({ [lhs] = { rhs, desc } }, { mode = mode, prefix = "<leader>" })
    end
  end
end

setup_keys(M.default)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspKeymap", { clear = true }),
  callback = function(args)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    local has_wk, wk = pcall(require, "which-key")

    for _, v in ipairs(M.lsp) do
      local mode, lhs, rhs, desc = unpack(v)
      keymap(args.buf, mode, lhs, rhs, vim.tbl_deep_extend("force", { desc = desc }, opts))

      if has_wk then
        wk.register({ [lhs] = { rhs, desc } }, { mode = mode, prefix = "<leader>" })
      end
    end
  end,
})

return M