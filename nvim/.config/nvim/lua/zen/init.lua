if vim.fn.has "nvim-0.10" ~= 1 then
  vim.notify("Please upgrade your Neovim. ZenVim requires v0.10+", vim.log.levels.WARN)
  vim.wait(5000, function()
    ---@diagnostic disable-next-line: redundant-return-value
    return false
  end)
  vim.cmd "cquit"
end

if vim.loader then
  vim.loader.enable()
end

require("zen.core")
