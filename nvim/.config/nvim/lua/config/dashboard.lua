local M = {}

local header = [[
╔═════════════════════════════════════════════════════════════════════╗
║ ██████   █████                   █████   █████  ███                 ║
║░░██████ ░░███                   ░░███   ░░███  ░░░                  ║
║ ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  ║
║ ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ ║
║ ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ ║
║ ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ ║
║ █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████║
║░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ ║
╚═════════════════════════════════════════════════════════════════════╝
]]

M.preset = {
  header = header,
  keys = {
    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
    { icon = " ", key = "n", desc = "New File", action = ":lua Nv0.new_file()" },
    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
  }
}

return M
