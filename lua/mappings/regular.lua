local map = require 'mappings.util'.map
local fish_style_abbr = require 'mappings.util'.fish_style_abbr
local M = {}

function M.setup()
  local autoindent = function(key)
    return function()
      return not vim.api.nvim_get_current_line():match "%g" and "cc" or key
    end
  end
  local noresilent = { noremap = true, silent = true }
  map({
    [{ "n" }] = {
      { ";",          ":",                         { desc = "CMD enter command mode" } },
      -- autoindent on insert/append
      { "I",          autoindent "I",              { expr = true } },
      { "i",          autoindent "i",              { expr = true } },
      { "A",          autoindent "A",              { expr = true } },
      { "a",          autoindent "a",              { expr = true } },
      { "x",          '"_dl' },
      { "X",          '"_dh' },
      { "k",          "v:count == 0 ? 'gk' : 'k'", { expr = true } },
      { "j",          "v:count == 0 ? 'gj' : 'j'", { expr = true } },
      { "<C-d>",      "<C-d>zz",                   noresilent },
      { "<C-u>",      "<C-u>zz",                   noresilent },
      { "YY",         "va{Vy",                     noresilent },
      { "n",          "nzz",                       noresilent },
      { "N",          "Nzz",                       noresilent },
      { "*",          "*zz",                       noresilent },
      { "#",          "#zz",                       noresilent },
      { "g*",         "g*zz",                      noresilent },
      { "g#",         "g#zz",                      noresilent },
      { "<C-n>",      ":w %:h/",                   noresilent },
      { "<leader>gs", "<cmd>Neogit<CR>",           { desc = "Open Neogit" } },
      {
        "<leader>tc",
        function()
          vim.g.cmp_disable = not vim.g.cmp_disable
          vim.notify((vim.g.cmp_disable and "Disabled" or "Enabled") .. " cmp", vim.log.levels.INFO)
        end,
        {
          desc = "toggle cmp",
        },
      },
      {
        "<leader>ta",
        function()
          vim.g.autocomplete_disable = not vim.g.autocomplete_disable
          vim.notify((vim.g.autocomplete_disable and "Disabled" or "Enabled") .. " autocomplete", vim.log.levels.INFO)
        end,
        {
          desc = "toggle autocomplete",
        },
      },
      {
        "<leader>-",
        "<cmd>sp<cr>",
        {
          desc = "horizontal split",
        },
      },
      {
        "<leader>|",
        "<cmd>vs<cr>",
        {
          desc = "vertical split",
        },
      },
    },
    [{ "n", "t" }] = {
      -- better tabs
      { "<localleader>n", "<cmd>tabnew<CR>",      { noremap = true, desc = "new tab" } },
      -- tab and shift tab go back and forward buffers?? in nvchad
      { "<localleader>>", "<cmd>tabnext<CR>",     { noremap = true, desc = "next tab" } },
      { "<localleader><", "<cmd>tabprevious<CR>", { noremap = true, desc = "previous tab" } },
      { "<localleader>c", "<cmd>tabclose<CR>",    { noremap = true, desc = "close tab" } },
      { "<localleader>1", "1gt",                  { desc = "switch to tab 1" } },
      { "<localleader>2", "2gt",                  { desc = "switch to tab 2" } },
      { "<localleader>3", "3gt",                  { desc = "switch to tab 3" } },
      { "<localleader>4", "4gt",                  { desc = "switch to tab 4" } },
      { "<localleader>5", "5gt",                  { desc = "switch to tab 5" } },
      { "<localleader>6", "6gt",                  { desc = "switch to tab 6" } },
      { "<localleader>7", "7gt",                  { desc = "switch to tab 7" } },
      { "<localleader>8", "8gt",                  { desc = "switch to tab 8" } },
      { "<localleader>9", "9gt",                  { desc = "switch to tab 9" } },
      { "<localleader>0", "10gt",                 { desc = "switch to tab 10" } },
      {
        "<Esc>",
        function()
          if vim.api.nvim_win_get_config(0).relative ~= "" then
            return "<Cmd>quit<CR>"
          end
          if vim.v.hlsearch == 1 then
            return "<Cmd>nohlsearch<CR>"
          end
          return "<Esc>"
        end,
        { expr = true },
      },
      { "<leader>fq", vim.cmd.bdelete, { desc = "quit file" } },
      { "<leader>fs", "<cmd>w<cr>",    { desc = "save file" } },
    },
    [{ "n", "v" }] = {
      { "p", "p=`]", { remap = true } },
      { "P", "P=`]", { remap = true } },
      -- { "<localleader>v", '"+p', { desc = "p (clipboard)" } },
      -- { "<localleader>V", '"+P', { desc = "P (clipboard)" } },
      -- { "<localleader>y", '"+y', { desc = "y (clipboard)" } },
      -- { "<leader>%", "<Cmd>%y<CR>", { desc = "yank file" } },
      -- { "<localleader>Y", '"+Y', { desc = "Y (clipboard)" } },
      -- { "<LeftRelease>", '"*ygv' }, -- on left mouse button release
      -- { "<C-X>", '"+d' },
      -- { "<C-V>", '"+p' },
      -- { "<C-C>", '"+y' },
    },
    [{ "ca" }] = {
      fish_style_abbr("L", "Lazy"),
      fish_style_abbr("V", "vert"),
      fish_style_abbr("VS", "vert sb"),
      fish_style_abbr("s", "s/g<Left><Left>"),
      -- fish_style_abbr("h", "vert h"),
      fish_style_abbr("w", function()
        local auto_p = "w ++p"
        if vim.env.USER == "root" then
          return auto_p
        end
        local prefixes = { "/etc" }
        for _, prefix in ipairs(prefixes) do
          if vim.startswith(vim.api.nvim_buf_get_name(0), prefix) then
            return "SudaWrite"
          end
        end
        return auto_p
      end),
      fish_style_abbr("!", "term"),
      fish_style_abbr("=", "term"),
    },
    [{ "v" }] = {
      {
        "J",
        ":m '>+1<CR>gv=gv",
        noresilent
      },
      {
        "K",
        ":m '<-2<CR>gv=gv",
        noresilent
      },
      { "<", "<gv" },
      { ">", ">gv" },
      { "p", '"_dp' },
      { "P", '"_dP' },
      { "x", '"_x' },
      { "X", '"_X' },
    },
    [{ "i" }] = {
      -- {
      -- '<Esc>',
      -- function()
      --   local col = vim.api.nvim_win_get_cursor(0)[2]
      --   return (col < 2) and 'l<esc>' or '<esc>'
      -- end,
      --   { expr = true },
      -- },
      { "<C-Return>",   "<Esc>o" },
      { "<C-S-Return>", "<Esc>O" },
    },
    [{ "n", "x", "o" }] = {
      { "H", "^",  noresilent },
      { "L", "g_", noresilent },
    },
  }, { silent = true })
end

return M
