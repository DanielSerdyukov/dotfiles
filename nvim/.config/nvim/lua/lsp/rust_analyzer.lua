local M = {}

function M.setup(options)
  -- local lsp_util = require("lspconfig/util")
  options = vim.tbl_deep_extend("force", options, {
    cargo = {
      allFeatures = true,
      loadOutDirsFromCheck = true,
      runBuildScripts = true,
    },
    -- Add clippy lints for Rust.
    checkOnSave = {
      allFeatures = true,
      command = "clippy",
      extraArgs = { "--no-deps" },
    },
    procMacro = {
      enable = true,
      ignored = {
        ["async-trait"] = { "async_trait" },
        ["napi-derive"] = { "napi" },
        ["async-recursion"] = { "async_recursion" },
      },
    },
  })
  require("lspconfig").rust_analyzer.setup(options)
end

return M