return { -- Integrated Tests -- CONFIG
  "nvim-neotest/neotest",

  keys = require 'mappings'.setup.tests({ lazy = true }),

  dependencies = {
    -- Required
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",

    -- Dev
    "rouge8/neotest-rust", -- Rust development
  },

  config = function(_, opts)
    require("neotest").setup {
      adapters = {
        require "neotest-rust",
        -- require "neotest-vim-test" {
        --   ignore_file_types = { "python", "vim", "lua" },
        -- },
      },
    }
  end,
}
