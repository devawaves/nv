return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy", -- FIXME: maybe lazy loadable?
    config = function(_, opts)
      require("dressing").setup(opts)
    end,
    opts = {
      default_prompt = "❯ ",
    },
  },

  -- delete buffer
  {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>bd",
        ":lua require('bufdelete').bufdelete(0, false)<cr>",
        { noremap = true, silent = true, desc = "Delete buffer" }
      )
    end,
  },

  -- Smooth scrolling neovim plugin written in lua
  {
    "karb94/neoscroll.nvim",
    -- enabled = false,
    lazy = false,
    config = function()
      require("neoscroll").setup({
        stop_eof = true,
        easing_function = "sine",
        hide_cursor = true,
        cursor_scrolls_alone = true,
      })
    end,
  },

  -- find and replace
  {
    "windwp/nvim-spectre",
    enabled = false,
    event = "BufRead",
    keys = {
      {
        "<leader>Rr",
        function()
          require("spectre").open()
        end,
        desc = "Replace",
      },
      {
        "<leader>Rw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace Word",
      },
      {
        "<leader>Rf",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Replace Buffer",
      },
    },
  },

  -- Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Heuristically set buffer options
  {
    "tpope/vim-sleuth",
  },

  {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    {                                        -- optional completion source for require statements and module annotations
      "yioneko/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
  },

  -- editor config support
  {
    "editorconfig/editorconfig-vim",
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufEnter",
    cmd = "TSJToggle",
    config = function()
      require("treesj").setup({ use_default_keymaps = false })
      vim.keymap.set('n', 'gJ', vim.cmd.TSJToggle, { desc = "Split/join line" })
    end,
  },
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex, augend.date.alias["%Y/%m/%d"],
          augend.hexcolor.new({ case = "lower" }),
          augend.constant.alias.bool,
        },
        visual = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.constant.alias.bool,
        },
      })

      vim.keymap.set('n', '<C-a>', function() return require("dial.map").inc_normal() end,
        { expr = true, noremap = true })
      vim.keymap.set('n', '<C-x>', function() return require("dial.map").dec_normal() end,
        { expr = true, noremap = true })
      vim.keymap.set('n', 'g<C-a>', function() return require("dial.map").inc_gnormal() end,
        { expr = true, noremap = true })
      vim.keymap.set('n', 'g<C-x>', function() return require("dial.map").dec_gnormal() end,
        { expr = true, noremap = true })

      vim.keymap.set('v', '<C-a>', function() return require("dial.map").inc_visual() end,
        { expr = true, noremap = true })
      vim.keymap.set('v', '<C-x>', function() return require("dial.map").dec_visual() end,
        { expr = true, noremap = true })
      vim.keymap.set('v', 'g<C-a>', function() return require("dial.map").inc_gvisual() end,
        { expr = true, noremap = true })
      vim.keymap.set('v', 'g<C-x>', function() return require("dial.map").dec_gvisual() end,
        { expr = true, noremap = true })
    end,
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = "BufWinEnter",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      })

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        -- "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
  -- persist sessions
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
  },

  -- better code annotation
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local neogen = require("neogen")

      neogen.setup({
        snippet_engine = "luasnip",
      })
    end,
    keys = {
      {
        "<leader>eg",
        function()
          require("neogen").generate()
        end,
        desc = "Generate code annotations",
      },
      {
        "<leader>ef",
        function()
          require("neogen").generate({ type = "func" })
        end,
        desc = "Generate Function Annotation",
      },
      {
        "<leader>et",
        function()
          require("neogen").generate({ type = "type" })
        end,
        desc = "Generate Type Annotation",
      },
    },
  },

  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      require("mini.pairs").setup()
      require('mini.bracketed').setup()
    end,
  },
  {
    "fladson/vim-kitty",
  },
  {
    "tpope/vim-sleuth"
  },
  { -- Minimap
    "gorbit99/codewindow.nvim",
    event = "VeryLazy",

    keys = {
      {
        "<leader>mo",
        "codewindow.toggle_minimap()",
        mode = "n",
        desc = "Toggle Minimap",
      },
      {
        "<leader>mm",
        "codewindow.toggle_focus()",
        mode = "n",
        desc = "Focus Minimap",
      },
    },

    config = function(_, opts)
      local codewindow = require "codewindow"
      codewindow.setup(opts)
      codewindow.apply_default_keybinds()
    end,

    opts = {
      show_cursor = false,
      screen_bounds = "lines",
      window_border = "none",
    },
  },
  {
    "debugloop/telescope-undo.nvim",

    keys = {
      { "<leader>fu", ":Telescope undo<CR>", mode = "n", desc = "Open Undo History" },
    },

    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        opts = {
          extensions = {
            undo = {
              side_by_side = true,
              layout_strategy = "vertical",
              layout_config = {
                preview_height = 0.8,
              },
            },
          },
        },
      },
    },

    config = function(_, opts)
      require("telescope").load_extension "undo"
    end,
  },
  {
    "rgroli/other.nvim",
    event = "VeryLazy",

    keys = {
      {
        "<leader>sw",
        "<cmd> Other<CR>",
        mode = "n",
        desc = "Switch To Pair File",
      },
    },

    config = function(_, opts)
      -- Iterate opts and add reversed mappings for them marked with reverse = true
      require("other-nvim").setup(opts)
    end,

    opts = {
      mappings = {
        {
          pattern = "(.*)/(.*).h$",
          target = "%1/%2.c",
        },
        {
          pattern = "(.*)/(.*).c$",
          target = "%1/%2.h",
        },
        {
          pattern = "(.*)/(.*).hpp$",
          target = "%1/%2.cpp",
        },
        {
          pattern = "(.*)/(.*).cpp$",
          target = "%1/%2.hpp",
        },
        -- {
        --   pattern = "/src/app/(.*)/.*.html$",
        --   target = "/src/app/%1/%1.component.ts",
        --   context = "view",
        -- },
        -- {
        --   pattern = "/src/app/(.*)/.*.ts$",
        --   target = "/src/app/%1/%1.component.html",
        --   context = "component",
        -- },
        -- {
        --   pattern = "/src/app/(.*)/.*.spec.ts$",
        --   target = "/src/app/%1/%1.component.html",
        --   context = "test",
        -- },
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",

    config = function()
      require("refactoring").setup({})
      -- require("telescope").load_extension "refactoring" -- unneeded when dressing.nvim is a thing
    end,
    event = "VeryLazy",

    keys = require 'mappings'.setup.refactoring({ lazy = true }),
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require("copilot").setup({})
    end
  },
  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },

    -- If you have a recent version of lazy.nvim, you don't need to add this!
    -- build = "nvim -l build/init.lua",
    config = function()
      require("sg").setup({})
    end
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    -- version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      behavior = {
        auto_suggestions = true,
      },
      mappings = {
        suggestion = {
          accept = "<C-a>"
        }
      }
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = ":AvanteBuild source=false",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}
