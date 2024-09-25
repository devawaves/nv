local M = {}

local wk = require "which-key"

M.prefixes = function()
  -- TODO: Rewise this frequently
  -- WhichKey prefixes:
  wk.add({
    { "<leader>f", group = " find" },
    { "<leader>b", group = "󱂬 buffer" },
    { "<leader>d", group = " debug" },
    { "<leader>n", group = " compiler explorer"},
    { "<leader>g", group = " git" },
    { "<leader>c", group = "󱃖 code" },
    { "<leader>h", group = "󱕘 harpoon" },
    { "<leader>s", group = " lsp" },
    { "<leader>q", group = "󰗼 quit" },
    { "<leader>r", group = " run" },
    { "<leader>o", group = " open" },
    { "<leader>u", group = "󰚰 update" },
    { "<leader>w", group = " workspace" },
  })
end

M.opts = {
  icons = {
    group = "", -- disable + to make Nerf fonts usable
  },
}

return M
