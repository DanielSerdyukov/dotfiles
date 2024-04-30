local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
}

function M.config()
  local dashboard = require("alpha.themes.dashboard")

  local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl_shortcut = "Include"
    return b
  end

  dashboard.section.header.val = {
    [[╔════════════════════════════════════════════════════════════════════╗]],
    [[║ ███████████                     █████   █████  ███                 ║]],
    [[║░█░░░░░░███                     ░░███   ░░███  ░░░                  ║]],
    [[║░     ███░    ██████  ████████   ░███    ░███  ████  █████████████  ║]],
    [[║     ███     ███░░███░░███░░███  ░███    ░███ ░░███ ░░███░░███░░███ ║]],
    [[║    ███     ░███████  ░███ ░███  ░░███   ███   ░███  ░███ ░███ ░███ ║]],
    [[║  ████     █░███░░░   ░███ ░███   ░░░█████░    ░███  ░███ ░███ ░███ ║]],
    [[║ ███████████░░██████  ████ █████    ░░███      █████ █████░███ █████║]],
    [[║░░░░░░░░░░░  ░░░░░░  ░░░░ ░░░░░      ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ ║]],
    [[╚════════════════════════════════════════════════════════════════════╝]],
  }

  dashboard.section.buttons.val = {
    button("f", Zen.icons.ui.Files .. " Find file", ":Telescope find_files <CR>"),
    button("n", Zen.icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
    button("p", Zen.icons.ui.Project .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
    button("r", Zen.icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
    button("t", Zen.icons.ui.Text .. " Find text", ":Telescope live_grep <CR>"),
    button("c", Zen.icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
    button("q", Zen.icons.ui.SignOut .. " Quit", ":qa<CR>"),
  }


  dashboard.section.header.opts.hl = "Keyword"
  dashboard.section.buttons.opts.hl = "Include"
  dashboard.section.footer.opts.hl = "Type"

  dashboard.opts.opts.noautocmd = true
  require("alpha").setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = " Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
      vim.cmd [[ set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3 ]]
    end,
  })
end

return M
