return {
  { -- nvim-dap UI
    "rcarriga/nvim-dap-ui",
    keys = {
      {
        "<leader>dq",
        function()
          require("dapui").eval()
        end,
        mode = { "n", "v" },
        desc = "Hover",
      },
      {
        "<leader>df",
        function()
          require("dapui").float_element()
        end,
        mode = "n",
        desc = "Lookup Options",
      },
    },

    config = function(_, opts)
      require("dapui").setup(opts)
      status.debug = true
    end,
  },

  { -- nvim-dap virtual text
    "theHamsta/nvim-dap-virtual-text",
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup(opts)
    end,
    opts = {},
  },

  { -- DAP REPL Autocompletion
    "rcarriga/cmp-dap",
    config = function(_, opts)
      require("cmp").setup {
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
      }
      require("cmp").setup.filetype({
        "dap-repl",
        "dapui_watches",
        "dapui_hover",
      }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
  },

  {
    "LiadOz/nvim-dap-repl-highlights",
    dependencies = "nvim-treesitter/nvim-treesitter",

    keys = {
      {
        "<leader>dp",
        function()
          require("nvim-dap-repl-highlights").setup_highlights()
        end,
        mode = "n",
        desc = "Set REPL Highlight",
      },
    },

    config = function()
      require("nvim-dap-repl-highlights").setup()
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
        },
        ensure_installed = {
          "dap_repl",
        },
      }
    end,
  },

  { -- Debug Adapter Protocol
    "mfussenegger/nvim-dap",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/cmp-dap",
      "LiadOz/nvim-dap-repl-highlights",
    },
    -- TODO: Move these to configs/nvim-dap.lua
    config = function()
    end,

    keys = require("configs.dap").keys,
  },
  { -- nvim-dap installer MAYBE
    "jay-babu/mason-nvim-dap.nvim",

    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },

    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        "codelldb", -- Rust, C/C++
        "python",
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
  },
}
