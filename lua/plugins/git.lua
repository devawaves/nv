return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
    },
    cmd = "Neogit",
    keys = {
      {
        "<leader>gn",
        "<cmd>Neogit<CR>",
        desc = "Neogit"
      },
    },
    opts = require 'configs.neogit'
  },
  {
    "pwntester/octo.nvim",
    dependencies = require("configs.octo").dependencies,
    opts = require "configs.octo".opts,
    keys = require "configs.octo".keys,
    cmd = require "configs.octo".cmd
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = require 'configs.gitsigns',
    keys = require 'mappings'.setup.gitsigns({ lazy = true })
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- not git, but it's okay
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>gU",
        ":UndotreeToggle<CR>",
        desc = "Toggle UndoTree"
      },
    }
  },
  {
    "topaxi/gh-actions.nvim",
    cmd = "GhActions",

    keys = {
      { "<leader>ga", "<cmd>GhActions<cr>", desc = "Open Github Actions" },
    },

    -- optional, you can also install and use `yq` instead.
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },

    config = function(_, opts)
      require("gh-actions").setup(opts)
    end,

    opts = {},
  },
}
