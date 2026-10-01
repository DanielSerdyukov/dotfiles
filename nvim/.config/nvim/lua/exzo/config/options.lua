local M = {}

local defaults = {
  autowrite = true, -- automatically save the buffer when switching away or leaving
  clipboard = "unnamedplus", -- sync Neovim clipboard with the system clipboard
  completeopt = "menu,menuone,noselect", -- completion menu behavior: always show, even for one item; no auto-select
  conceallevel = 2, -- fully conceal concealed syntax (links, markup)
  confirm = true, -- ask for confirmation instead of failing on unsaved changes when quitting
  cursorline = true, -- highlight the screen line of the cursor
  expandtab = true, -- use spaces instead of a tab character when pressing <Tab>
  fillchars = { -- characters used to draw UI elements
    foldopen = "", -- marker shown on an open fold
    foldclose = "", -- marker shown on a closed fold
    fold = " ", -- filler for the rest of a partly closed fold
    foldsep = " ", -- separator used between folds
    diff = "╱", -- deleted/changed lines in diffs
    eob = " ", -- empty lines past the end of the buffer (blank instead of ~)
  },
  foldlevel = 99, -- start with all folds open
  grepformat = "%f:%l:%c:%m", -- parse :grep output as file:line:col:message (matches rg --vimgrep)
  grepprg = "rg --vimgrep", -- use ripgrep for :grep
  ignorecase = true, -- case-insensitive searching...
  inccommand = "nosplit", -- show :substitute preview incrementally, in place
  jumpoptions = "view", -- restore the view (folds, window) when jumping through the jumplist
  laststatus = 2, -- single global statusline for all windows
  linebreak = true, -- soft-wrap long lines at word boundaries instead of mid-word
  list = true, -- show invisible characters (see 'listchars')
  mouse = "a", -- enable the mouse in all modes
  number = true, -- show absolute line numbers
  pumblend = 10, -- popup menu transparency
  pumheight = 10, -- max popup menu height
  relativenumber = true, -- show relative line numbers (current line stays absolute)
  scrolloff = 8, -- min lines of context kept above/below the cursor
  sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }, -- what :mksession saves
  shiftround = true, -- round indent shifts (< and >) to a multiple of shiftwidth
  shiftwidth = 2, -- spaces per indentation level
  shortmess = "ltToOCFcI", -- trim various messages (no intro screen, etc.)
  showmode = false, -- hide -- INSERT -- message (a statusline shows it instead)
  sidescrolloff = 8, -- min columns of context kept left/right of the cursor
  signcolumn = "yes", -- always show the sign column (no layout shift on diagnostics)
  smartcase = true, -- ...unless the search pattern contains uppercase
  smartindent = true, -- auto-indent new lines based on context
  smoothscroll = true, -- scroll by screen lines when 'wrap' is on
  splitbelow = true, -- new horizontal splits open below the current window
  splitkeep = "screen", -- keep text in view when opening/closing splits
  splitright = true, -- new vertical splits open to the right of the current window
  tabstop = 2, -- columns a tab character counts for
  termguicolors = true, -- enable 24-bit RGB color in the TUI
  timeoutlen = 300, -- ms to wait for a mapped key sequence to complete
  undofile = true, -- persistent undo history across sessions
  undolevels = 10000, -- max undo steps per buffer
  updatetime = 200, -- ms idle before swap write and CursorHold events fire
  virtualedit = "block", -- let the cursor move past end of line in visual block mode
  wildmode = "longest:full,full", -- command-line completion: longest match, then full list
  winminwidth = 5, -- minimum window width
  wrap = false, -- don't soft-wrap long lines; they extend beyond the screen
}

function M.setup(opts)
  vim.g.mapleader = opts.leader
  vim.g.maplocalleader = opts.leader

  local options = vim.tbl_deep_extend(
    "force",
    vim.deepcopy(defaults),
    opts.options or {}
  )

  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

return M
