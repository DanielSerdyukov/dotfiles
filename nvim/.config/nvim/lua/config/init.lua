vim.uv = vim.uv or vim.loop

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

_G.Nv0 = require("utils")

local M = {}

local colorscheme = {
  theme = {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup()
      vim.cmd("colorscheme nightfox")
    end
  }
}

M.did_setup = false
M.setup = function(opts)
  if M.did_setup then
    return
  end

  _G.Nv0.config = Nv0.extend(opts or {}, {
  })

  require("config.options")

  require("lazy").setup({
    Nv0.extend(opts.colorscheme or colorscheme, {
      priority = 1000,
      lazy = false,
    }),
    { import = "plugins" }
  }, require("config.lazy"))

  require("config.autocmds")
  Nv0.keymaps.set(opts.keymaps or {})

  M.did_setup = true
end

return M
