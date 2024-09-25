return {
  "krady21/compiler-explorer.nvim",

  config = function(_, opts)
    require("compiler-explorer").setup(opts)
  end,

  opts = {
    url = "https://godbolt.org",
    infer_lang = true, -- Try to infer possible language based on file extension.
    line_match = {
      -- FIXME: defaults are false and they don't work
      -- highlight = true, -- highlight the matching line(s) in the other buffer.
      -- jump = true, -- move the cursor in the other buffer to the first matching line.
    },
    open_qflist = true,     --  Open qflist after compilation if there are diagnostics.
    split = "split",        -- How to split the window after the second compile (split/vsplit).
    compiler_flags = "",    -- Default flags passed to the compiler.
    job_timeout_ms = 25000, -- Timeout for libuv job in milliseconds.
    languages = {           -- Language specific default compiler/flags
      --c = {
      --  compiler = "g121",
      --  compiler_flags = "-O2 -Wall",
      --},
    },
  },

  -- cmd = { -- TODO
  --   ":CECompile",
  --   ":CECompileLive",
  --   ":CEFormat",
  --   ":CEAddLibrary",
  --   ":CELoadExample",
  --   ":CEOpenWebsite",
  --   ":CEDeleteCache",
  --   ":CEShowTooltip",
  --
  --   ":CEGotoLabel",
  -- },
  event = "VeryLazy",
  keys = { --- IDK wheter they work under v mode
    -- stylua: ignore start
    { "<leader>nc", ":CECompile<CR>",     mode = "n", desc = "Compile" },
    { "<leader>nl", ":CECompileLive<CR>", mode = "n", desc = "Compile Live" },
    { "<leader>nf", ":CEFormat<CR>",      mode = "n", desc = "Format" },
    { "<leader>na", ":CEAddLibrary<CR>",  mode = "n", desc = "Add Library" },
    { "<leader>ne", ":CELoadExample<CR>", mode = "n", desc = "Load Example" },
    { "<leader>nw", ":CEOpenWebsite<CR>", mode = "n", desc = "Open Website" },
    { "<leader>nd", ":CEDeleteCache<CR>", mode = "n", desc = "Delete Cache" },
    { "<leader>ns", ":CEShowTooltip<CR>", mode = "n", desc = "Show Tooltip" },
    { "<leader>ng", ":CEGotoLabel<CR>",   mode = "n", desc = "Goto Label" },
    -- stylua: ignore end
  },
}
