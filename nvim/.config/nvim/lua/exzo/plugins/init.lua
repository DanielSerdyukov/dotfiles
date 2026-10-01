---@class ExzoPluginSpec
---@field src string
---@field name string
---@field events? string[]
---@field setup? fun()

local M = {}

---@type ExzoPluginSpec[]
local defaults = {

}

---@param spec ExzoPluginSpec
local function load(spec)
  vim.cmd.packadd(spec.name)
  if type(spec.setup) == "function" then
    spec.setup()
  end
end

---@param config ExzoConfig
function M.setup(config)
  -- Only { src, name } goes to vim.pack; `events` and `setup` are
  -- exzo-only fields.
  local by_name = {}
  local pack_specs = {}
  for _, spec in ipairs(config.plugins or {}) do
    by_name[spec.name] = spec
    pack_specs[#pack_specs + 1] = { src = spec.src, name = spec.name }
  end

  -- Install everything at once; decide per plugin when to load it.
  vim.pack.add(pack_specs, {
    load = function(plug_data)
      local spec = by_name[plug_data.spec.name]
      local events = spec.events or {}

      if #events == 0 then
        load(spec)
        return
      end

      vim.api.nvim_create_autocmd(events, {
        once = true,
        callback = function()
          load(spec)
        end,
      })
    end,
  })
end

return M
