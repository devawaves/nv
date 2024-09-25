return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- Autotags
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },

  -- useful when there are embedded languages in certain types of files (e.g. Vue or React)
  { "joosepalviste/nvim-ts-context-commentstring", lazy = true },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    lazy = false,
    config = require 'configs.hop'.setup
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = require 'configs.treesitter'
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"

      conf.defaults.mappings.i = {
        ["<M-j>"] = require("telescope.actions").move_selection_next,
        ["<M-k>"] = require("telescope.actions").move_selection_previous,
      }

      return conf
    end,
  },
  {
    "simrat39/symbols-outline.nvim",

    keys = {
      {
        "<leader>fs",
        ":SymbolsOutline<CR>",
        mode = "n",
        desc = "Find Symbols",
      },
    },

    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end,

    opts = {},
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      require("neogen").setup(opts)
    end,

    opts = {
      snippet_engine = "luasnip",
    },

    keys = {
      {
        "<leader>cd",
        "<cmd>lua require('neogen').generate()<CR>",
        mode = "n",
        desc = "Generate Base Documentation",
      },
    },
  },
  {
    --          DEFINITELY TAKE A LOOK
    --             IT's AWESOME!!!
    -- -> https://github.com/CKolkey/ts-node-action <-
    --
    -- !!! INTEGRATED WITH BUILT-IN CODE ACTIONS !!!
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },

    keys = {
      {
        "<leader>cs",
        function()
          require("ts-node-action").node_action()
        end,
        mode = "n",
        desc = "Treesitter Code Action", -- Actually Node but...
      },
    },

    config = function(_, opts)
      -- Repo says it is not required if not using custom actions
      require("ts-node-action").setup(opts)
    end,
    opts = require("configs.ts").opts,
  },
  {                     -- Show lsp signature help when in a function (param info)
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy", -- TODO: Add keys to enable as mode
    opts = {
      hint_prefix = "",
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  { -- Folding. The fancy way
    "kevinhwang91/nvim-ufo",

    -- event = "VeryLazy",
    keys = require("configs.ufo").keys,
    dependencies = require("configs.ufo").dependencies,
    opts = require("configs.ufo").opts,

    config = function(_, opts)
      require("ufo").setup(opts)

      -- Better UI elements
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      -- vim.o.foldcolumn = "3" -- "1" is better
    end,
  },
  {
    "nvim-neotest/nvim-nio",
    event = "VeryLazy"
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    event = "LspAttach",
  }
}
