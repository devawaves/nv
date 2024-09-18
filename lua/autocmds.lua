local autocmds = {}

-- a function to create a function that creates autocmds for an augroup
function autocmds.create_wrapper(augroup_name)
  local augroup = vim.api.nvim_create_augroup(augroup_name, { clear = true })
  return function(event, opts)
        opts.group = opts.group or augroup
        return vim.api.nvim_create_autocmd(event, opts)
      end,
      augroup
end

autocmds.create, autocmds.waves_augroup = autocmds.create_wrapper "waves"

autocmds.create("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
  desc = "Highlight on yank",
})
autocmds.create("BufReadPost", {
  pattern = "*",
  desc = "Restore cursor position",
  callback = function()
    local fn = vim.fn
    if fn.line "'\"" > 0 and fn.line "'\"" <= fn.line "$" then
      fn.setpos(".", fn.getpos "'\"")
      -- vim.cmd.normal('zz')
      vim.cmd "silent! foldopen"
    end
  end,
})

autocmds.create("DiagnosticChanged", {
  desc = "Update loclist",
  callback = function()
    vim.diagnostic.setloclist { open = false }
  end,
})

local exrc_names = {
  ".nvim.lua",
  ".nvimrc",
  ".exrc",
}
autocmds.create("DirChanged", {
  desc = "Auto-read exrc",
  callback = function() end,
})

-- wrap words "softly" (no carriage return) in mail buffer
autocmds.create("FileType", {
  pattern = "mail",
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.columns = 80
    vim.opt.colorcolumn = "80"
  end
})

-- don't auto comment newline
autocmds.create("BufEnter", {
  command = [[set formatoptions-=cro]]
})

autocmds.create("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

autocmds.create("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- resize neovim split when terminal is resized
vim.api.nvim_command("autocmd VimResized * wincmd =")

-- fix terraform and hcl comment string
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl" },
})

return autocmds
