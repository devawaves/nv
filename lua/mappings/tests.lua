local M = {}
local map = require 'mappings.util'.map

M.setup = function(opts)
  return map({
    [{ "n" }] = {
      { "<leader>to", ":Neotest summary<CR>", { desc = "Open interactive test session" } },
      { "<leader>te", ":Neotest run<CR>",     { desc = "Run tests for the session" } },
      { "<leader>tf", function()
        require("neotest").output_panel.toggle()
      end, { desc = "Toggle test panel" } },
      { "<leader>tq", function()
        require("neotest").output.open { enter = true }
      end, { desc = "Open test results" } },
    }
  }, {}, opts)
end

return M
