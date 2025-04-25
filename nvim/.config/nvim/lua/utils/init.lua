-- This file is automatically loaded by config.core
local LazyUtil = require("lazy.core.util")

local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    t[k] = require("utils." .. k)
    return t[k]
  end,
})

M.extend = function(...)
  return vim.tbl_deep_extend("force", ...)
end

M.new_file = function()
  vim.ui.input({ prompt = "New file name: " }, function(input)
    if input == nil or input == "" then return end

    -- Create a new empty buffer
    vim.cmd("enew") -- like :enew

    -- Set the name of the buffer (virtual until saved)
    vim.api.nvim_buf_set_name(0, vim.fn.expand("%:p:h") .. "/" .. input)

    -- Optional: set the filetype automatically
    vim.cmd("filetype detect")
  end)
end

M.get_plugin = function(name)
  return require("lazy.core.config").spec.plugins[name]
end

M.has_plugin = function(name)
  return M.get_plugin(name) ~= nil
end

M.plugin_opts = function(name)
  local plugin = M.get_plugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

M.inspect = function(...)
  Snacks.debug.inspect(...)
end

return M
