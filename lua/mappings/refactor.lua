local M = {}
local map = require 'mappings.util'.map

function M.setup(opts)
  return map({
    -- [{ "n", "v" }] = { "<leader>cr", function()
    --   require("refactoring").select_refactor()
    -- end, { desc = "List Refactorings" } },
    [{"n","v"}] = {
      { "<leader>cr", ":lua require('refactoring').select_refactor()<cr>", { desc = "List Refactorings" } }
    },
    [{ "n" }] = {
      { "<leader>ce", ":Refactor extract<CR>",               { desc = "Extract To Function" } },
      { "<leader>cv", ":Refactor extract_var<CR>",           { desc = "Extract To Variable" } },
      { "<leader>cb", ":Refactor extract_block<CR>",         { desc = "Extract To Block" } },
      { "<leader>cg", ":Refactor extract_block_to_file<CR>", { desc = "Extract Block To File" } },
      { "<leader>cn", ":Refactor refactor_names<CR>",        { desc = "Refactor names" } },
      { "<leader>cf", ":Refactor extract_to_file<CR>",       { desc = "Extract to file" } },
      { "<leader>ci", ":Refactor inline_var<CR>",            { desc = "Inline Variable" } },

      { "<leader>ce", ":Refactor extract<CR>",               { desc = "Extract To Function" } },
      { "<leader>cv", ":Refactor extract_var<CR>",           { desc = "Extract To Variable" } },
      { "<leader>cb", ":Refactor extract_block<CR>",         { desc = "Extract To Block" } },
      { "<leader>cg", ":Refactor extract_block_to_file<CR>", { desc = "Extract Block To File" } },
      { "<leader>cn", ":Refactor refactor_names<CR>",        { desc = "Refactor names" } },
      { "<leader>cf", ":Refactor extract_to_file<CR>",       { desc = "Extract to file" } },
      { "<leader>ci", ":Refactor inline_var<CR>",            { desc = "Inline Variable" } },
    }
  }, {}, opts)
end

return M
