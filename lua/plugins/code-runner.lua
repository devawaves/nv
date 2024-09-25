return {
  {
    "Zeioth/compiler.nvim",
    keys = require 'mappings'.setup.code_runner({ lazy = true }),
    cmd = {
      "CompilerOpen",
      "CompilerToggleResults",
      "CompilerRedo"
    },
    dependencies = {
      "stevearc/overseer.nvim",
    },
    opts = {}
  },
  { -- The task runner for compiler.nvim + daily tasks
    "stevearc/overseer.nvim",
    -- commit = "19aac0426710c8fc0510e54b7a6466a03a1a7377",
    keys = require 'mappings'.setup.overseer({ lazy = true }),

    cmd = {
      "CompilerOpen",
      "CompilerToggleResults",
      "CompilerRedo",
    },

    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ["q"] = function()
            vim.cmd "OverseerClose"
          end,
        },
      },
    },
  }
}
