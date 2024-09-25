local M = {}
local map = require 'mappings.util'.map

function M.code_runner(opts)
  return map({
    [{ "n" }] = {
      { "<leader>rr", ":CompilerOpen<CR>",          { desc = "Run Project" } },
      { "<leader>rt", ":CompilerToggleResults<CR>", { desc = "Toggle Results" } },
    }
  }, {}, opts)
end

function M.overseer(opts)
  return map({
    [{ "n" }] = {
      { "<leader>ra", function()
        vim.cmd [[OverseerRun]]
        vim.cmd [[OverseerOpen]]
      end, { desc = "Run Task" } },
    }
  }, {}, opts)
end

return M
