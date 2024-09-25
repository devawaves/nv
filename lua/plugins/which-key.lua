return {
  "folke/which-key.nvim",
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "whichkey") -- from nvchad
    require("which-key").setup(opts)         -- from nvchad
    require("configs.which-key").prefixes()  -- vimacs
  end,
  opts = require("configs.which-key").opts
}
