---@class ExzoConfig
---@field leader string
---@field colorscheme? string
---@field options table<string, any>
---@field plugins ExzoPluginSpec[]

local M = {}

---@type ExzoConfig
local defaults = {
  leader = " ",
  colorscheme = "catppuccin-mocha",
  options = {},
  plugins = {}
}

---@param opts? ExzoConfig
---@return ExzoConfig
function M.setup(opts)
  return vim.tbl_deep_extend(
    "force",
    vim.deepcopy(defaults),
    opts or {}
  )
end

return M
