require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local g = vim.g
local o = vim.opt


g.loaded_netrw = 1                                -- disable netrw
g.loaded_netrwPlugin = 1                          --  disable netrw

o.incsearch = true                                -- make search act like search in modern browsers
o.backup = false                                  -- creates a backup file
o.clipboard = "unnamedplus"                       -- allows neovim to access the system clipboard
o.cmdheight = 1                                   -- more space in the neovim command line for displaying messages
o.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
-- o.conceallevel = 2 -- :h cole
o.conceallevel = 0                                -- :h cole
o.fileencoding = "utf-8"                          -- the encoding written to a file
o.hlsearch = true                                 -- highlight all matches on previous search pattern
o.ignorecase = true                               -- ignore case in search patterns
o.mouse = "a"                                     -- allow the mouse to be used in neovim
o.pumheight = 10                                  -- pop up menu height
o.showmode = false                                -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 0                                 -- always show tabs
o.smartcase = true                                -- smart case
o.smartindent = true                              -- make indenting smarter again
o.splitbelow = true                               -- force all horizontal splits to go below current window
o.splitright = true                               -- force all vertical splits to go to the right of current window
o.swapfile = false                                -- creates a swapfile
o.termguicolors = true                            -- set term gui colors (most terminals support this)
o.timeoutlen = 250                                -- time to wait for a mapped sequence to complete (in milliseconds)
o.undofile = true                                 -- enable persistent undo
o.updatetime = 100                                -- faster completion (4000ms default)
o.writebackup = false                             -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
-- o.expandtab = true -- convert tabs to spaces
-- o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.cursorline = false        -- highlight the current line
o.number = true             -- set numbered lines
o.breakindent = true        -- wrap lines with indent
o.relativenumber = true     -- set relative numbered lines
o.numberwidth = 4           -- set number column width to 2 {default 4}
o.signcolumn = "yes"        -- always show the sign column, otherwise it would shift the text each time
o.wrap = false              -- display lines as one long line
o.scrolloff = 8             -- Makes sure there are always eight lines of context
o.sidescrolloff = 8         -- Makes sure there are always eight lines of context
o.showcmd = false           -- Don't show the command in the last line
o.ruler = false             -- Don't show the ruler
o.guifont = "monospace:h17" -- the font used in graphical neovim applications
o.title = true              -- set the title of window to the value of the titlestring
o.confirm = true            -- confirm to save changes before exiting modified buffer
o.fillchars = { eob = " " } -- change the character at the end of buffer
-- o.guicursor = ""                          -- set the cursor to be a vertical bar

-- o.cursorlineopt = "number"              -- set the cursorline
-- o.tabstop = 2                           -- insert 2 spaces for a tab
o.laststatus = 3 -- Always display the status line

-- tabs
o.tabstop = 2
-- o.vartabstop = "2" -- all tabs represented as two spaces
o.shiftwidth = 0   -- tabstop
o.softtabstop = -1 -- use shiftwidth
o.expandtab = true -- <Tab> inserts spaces, ^V<Tab> inserts <Tab>

o.history = 1000
o.sessionoptions = {
  -- :h 'sessionoptions'
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "globals",
  "terminal",
  "options",
}
o.whichwrap:append("<,>,h,l,[,]")
o.foldlevelstart = 4
o.foldtext = ""
o.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  eob = " ",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
  diff = "╱",
}
o.list = true
o.listchars = {
  extends = "⟩",
  precedes = "⟨",
  trail = "·",
  tab = "╏ ",
  nbsp = "␣",
  -- eol = "󰌑",
}
o.wildoptions:append("fuzzy") --  add fuzzy completion to cmdline-completion
o.diffopt = {
  -- :h 'diffopt'
  "internal",
  "filler",
  "vertical",
  "linematch:60",
}

vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
