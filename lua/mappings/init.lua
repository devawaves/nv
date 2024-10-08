require "nvchad.mappings"
local M = {}

-- inspired by pynappo's keymaps file!
-- https://github.com/pynappo/dotfiles/blob/44fae21f47aa8c28d78deef3e1d4c59571f16bdb/.config/nvim/lua/pynappo/keymaps/init.lua
M.setup = {
  regular = require 'mappings.regular'.setup,
  gitsigns = require 'mappings.gitsigns'.setup,
  code_runner = require 'mappings.runner'.code_runner,
  overseer = require 'mappings.runner'.overseer,
  tests = require 'mappings.tests'.setup,
  refactoring = require 'mappings.refactor'.setup
}

M.cmp = require 'mappings.cmp'

return M
