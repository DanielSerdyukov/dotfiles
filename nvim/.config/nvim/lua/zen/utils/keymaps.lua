local M = {}

function M.set(keymaps, options)
  local utils = require("zen.utils")
  local buffer = vim.api.nvim_get_current_buf()
  local has_wk, wk = pcall(require, "which-key")

  local function prefix(lhs)
    if string.sub(lhs, 1, string.len("<leader>")) == "<leader>" then
      return nil
    else
      return "<leader>"
    end
  end

  for _, spec in ipairs(keymaps) do
    if type(spec) == "function" then
      M.set(spec(buffer))
    elseif type(spec) == "table" then
      ---@diagnostic disable-next-line: deprecated
      local mode, lhs, cmd, desc = unpack(spec, 1, 4)

      local opts = utils.merge(
        {
          desc = desc,
          noremap = spec.noremap ~= false,
          silent = spec.silent ~= false,
          callback = spec.callback,
        },
        options or {}
      )

      vim.keymap.set(mode, lhs, cmd, utils.merge({
        desc = desc,
        noremap = spec.noremap ~= false,
        silent = spec.silent ~= false,
        callback = spec.callback,
      }, options or {}))

      if has_wk then
        wk.register({ [lhs] = { cmd, desc }, prefix = prefix(lhs) })
      end
    end
  end
end

return M
