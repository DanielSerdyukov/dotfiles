local M = {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  local sections = {
    lualine_c = {
      { 'filename' },
    }
  }

  local has_navic, navic = pcall(require, "nvim-navic")
  if has_navic then
    table.insert(sections.lualine_c, {
      function()
        return navic.get_location()
      end,
      cond = function()
        return navic.is_available()
      end
    })
  end

  require("lualine").setup {
    sections = sections
  }
end

return M
