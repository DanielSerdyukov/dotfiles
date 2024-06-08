-- set up lazy.nvim to install plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("zen.config")

require('lazy').setup({
  spec = require("zen.plugins"),
  ui = {
    border = "rounded",
    size = { width = 0.7, height = 0.7 },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("_set_keymaps", { clear = true }),
  pattern = "VeryLazy",
  callback = function(event)
    local utils = require("zen.utils")
    local keymaps = require("zen.config.keymaps")
    utils.keymaps.set(keymaps.global)
  end,
})
