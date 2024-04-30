return function(options)
  require("lspconfig").rust_analyzer.setup(vim.tbl_deep_extend("force", {}, options, {
    handlers = {
      ["experimental/serverStatus"] = function(_, result, ctx)
        if result.health == "ok" and result.quiescent then
          vim.lsp.inlay_hint.enable(false)
          vim.lsp.inlay_hint.enable(true)
        end
      end,
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      checkOnSave = {
        allFeatures = true,
        command = "check",
      },
      procMacro = {
        enable = true,
        -- ignored = {
        --   ["async-trait"] = { "async_trait" },
        --   ["napi-derive"] = { "napi" },
        --   ["async-recursion"] = { "async_recursion" },
        -- },
      },
    },
  }))
end
