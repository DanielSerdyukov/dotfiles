local Themes = {}

function Themes.gruvbox()
  return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      if vim.fn.has("termguicolors") == 1 then
        vim.opt.termguicolors = true
      end

      vim.g.gruvbox_material_sign_column_background = 'none'
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1

      vim.cmd([[colorscheme gruvbox-material]])
    end,
  }
end

--~ https://github.com/EdenEast/nightfox.nvim/blob/main/usage.md
function Themes.nightfox()
  return {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup()
      vim.cmd("colorscheme carbonfox")
    end
  }
end


return Themes.gruvbox()
