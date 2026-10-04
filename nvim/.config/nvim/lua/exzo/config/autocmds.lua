local M = {}

---@param name string
---@return integer
local function augroup(name)
  return vim.api.nvim_create_augroup("exzo_" .. name, { clear = true })
end

---@param _ ExzoConfig
function M.setup(_)
  -- Highlight on yank
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
      if vim.fn.has("nvim-0.13") == 1 then
        vim.hl.hl_op()
      else
        (vim.hl or vim.highlight).on_yank()
      end
    end,
  })

  -- Equalize splits if terminal window is resized
  vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("resize_splits"),
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
    end,
  })

  -- Restore cursor to last known location when opening a buffer
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
      local exclude = { "gitcommit" }
      local buf = event.buf
      if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].exzo_last_loc then
        return
      end
      vim.b[buf].exzo_last_loc = true
      local mark = vim.api.nvim_buf_get_mark(buf, '"')
      local lcount = vim.api.nvim_buf_line_count(buf)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  -- Close utility filetypes with <q>
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
      "checkhealth",
      "gitsigns-blame",
      "help",
      "lspinfo",
      "man",
      "notify",
      "qf",
      "startuptime",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.schedule(function()
        vim.keymap.set("n", "q", function()
          vim.cmd("close")
          pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
        end, {
          buffer = event.buf,
          silent = true,
          desc = "Quit buffer",
        })
      end)
    end,
  })

  -- Auto create parent directories when saving a file
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(event)
      if event.match:match("^%w%w+:[\\/][\\/]") then
        return
      end
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
  })

  -- Universal `LazyFile` event: fires `User LazyFile` exactly once,
  -- deferred, the first time nvim opens a real file (not a scratch or
  -- dashboard buffer). Plugins lazy-load on it via events = { "LazyFile" }
  -- (see exzo.plugins). The original buffer event is replayed afterwards
  -- so late-loaded plugins still see the first buffer (mirrors lazy.nvim).
  local lazy_file_armed = true
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = augroup("lazy_file"),
    callback = function(event)
      if not lazy_file_armed then
        return
      end
      if event.file == "" or vim.bo[event.buf].buftype ~= "" then
        return
      end
      lazy_file_armed = false

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyFile",
        once = true,
        callback = function()
          vim.api.nvim_exec_autocmds(event.event, {
            buffer = event.buf,
            data = event.data,
          })
        end,
      })
      -- Deferred so plugin loading doesn't block the first paint.
      vim.schedule(function()
        vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile" })
      end)
    end,
  })
end

return M