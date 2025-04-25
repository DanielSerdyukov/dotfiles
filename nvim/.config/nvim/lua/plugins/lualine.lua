return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  config = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local options = {
      theme = "auto",
      globalstatus = vim.o.laststatus == 3,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "snacks_dashboard" } },
    }

    local sections = {
      lualine_c = {
        { 'filename' },
      }
    }

    if Nv0.has_plugin("nvim-navic") then
      table.insert(sections.lualine_c, {
        "navic", color_correction = "dynamic"
      })
    end

    require("lualine").setup({
      options = options,
      sections = sections
    })
  end
}
