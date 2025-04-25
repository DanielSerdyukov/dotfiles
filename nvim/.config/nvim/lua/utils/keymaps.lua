local M = {}

M.set = function(keymaps, opts)
  if type(keymaps) == "function" then
    M.set(keymaps(), opts)
  elseif type(keymaps) == "table" then
    for _, spec in ipairs(keymaps) do
      local mode = spec.mode or { "n" }
      local modes = type(mode) == "string" and { mode } or mode
      local key_opts = Nv0.extend({
        desc = spec.desc,
        noremap = spec.noremap ~= false,
        silent = spec.silent ~= false,
        nowait = spec.nowait ~= false,
        callback = spec.callback,
        buffer = spec.buffer,
      }, opts or {})

      local has_wk, wk = pcall(require, "which-key")
      if has_wk then
        wk.add(Nv0.extend({ spec[1], spec[2], }, key_opts, { mode = modes }))
      else
        vim.keymap.set(modes, spec[1], spec[2], key_opts)
      end
    end
  end
end

return M
