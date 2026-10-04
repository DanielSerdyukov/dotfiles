---@class ExzoPluginSpec
---@field src string
---@field name string
---@field events? string[] real autocmd events, or "LazyFile" (universal
---event armed in `exzo.config.autocmds`; fires on first real file opened)
---@field setup? fun()

local M = {}

---@type ExzoPluginSpec[]
local defaults = {

}

local loaded = {}

---@param spec ExzoPluginSpec
local function load(spec)
  if loaded[spec.name] then
    return
  end
  loaded[spec.name] = true

  vim.cmd.packadd(spec.name)
  if type(spec.setup) == "function" then
    spec.setup()
  end
end

---@param config ExzoConfig
function M.setup(config)
  local specs = {}
  for _, name in ipairs(config.plugins or {}) do
    local ok, spec = pcall(require, "exzo.plugins." .. name)
    if ok then
      specs[#specs + 1] = spec
    end
  end

  local by_name = {}
  local pack_specs = {}
  for _, spec in ipairs(specs) do
    by_name[spec.name] = spec
    pack_specs[#pack_specs + 1] = {
      src = spec.src,
      name = spec.name
    }
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

      for _, ev in ipairs(events) do
        local pattern
        if ev == "LazyFile" then
          ev, pattern = "User", "LazyFile"
        end
        local opts = {
          once = true,
          callback = function()
            load(spec)
          end,
        }
        if pattern then
          opts.pattern = pattern
        end
        vim.api.nvim_create_autocmd(ev, opts)
      end
    end,
  })
end

return M
