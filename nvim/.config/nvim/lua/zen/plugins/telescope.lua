local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      lazy = true,
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      lazy = true,
    }
  },
}

function M.config()
  local telescope = require("telescope")

  telescope.setup {
    defaults = {
      prompt_prefix = Zen.icons.ui.Telescope,
      selection_caret = Zen.icons.ui.Caret,
      path_display = { "smart" },
      entry_prefix = "  ",
      initial_mode = "insert",
      color_devicons = true,
      mappings = {
        i = {
          ["<Esc>"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
    pickers = {
      find_files = {
        find_command = {
          "fd",
          "--type",
          "f",
          "--hidden",
          "--strip-cwd-prefix",
          "--exclude",
          ".git",
          ".",
        },
      },
      diagnostics = {
        theme = "dropdown",
      },
      buffers = {
        theme = "dropdown",
      },
      lsp_references = {
        theme = "dropdown",
      },
      lsp_document_symbols = {
        theme = "dropdown",
      },
      lsp_workspace_symbols = {
        theme = "dropdown",
      },
      current_buffer_fuzzy_find = {
        theme = "dropdown",
        previewer = false,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
      }
    },
  }

  telescope.load_extension("fzf")
  telescope.load_extension("ui-select")

  local has_project, _ = pcall(require, "project_nvim")
  if has_project then
    telescope.load_extension("projects")
  end
end

return M
