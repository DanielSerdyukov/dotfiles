local M = {}

M.setup = function()
  Snacks.toggle.indent():map("<leader>ti")
  Snacks.toggle.inlay_hints():map("<leader>th")
  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tr")
  Snacks.toggle({
    name = "Auto Format",
    get = function()
      return vim.g.autoformat == nil or vim.g.autoformat
    end,
    set = function(value)
      vim.g.autoformat = value
    end
  }):map("<leader>tf")
  Snacks.toggle({
    name = "Code[L]ens",
    get = function()
      return vim.g.codelens == nil or vim.g.codelens
    end,
    set = function(value)
      vim.g.codelens = value
      if vim.g.codelens == nil or vim.g.codelens then
        vim.lsp.codelens.refresh()
      else
        vim.lsp.codelens.clear()
      end
    end
  }):map("<leader>tl")
end

return M
