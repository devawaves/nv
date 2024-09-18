local map = require 'mappings.util'.map
local M = {}

function M.setup(opts)
  return map({
    [{"n"}] = {
      { "<leader>gk", function()
        require("gitsigns").prev_hunk({ navigation_message = false })
      end, { desc = "Prev Hunk" } },
      { "<leader>gl", function()
        require("gitsigns").blame_line()
      end, { desc = "Blame" } },
      { "<leader>gp", function()
        require("gitsigns").preview_hunk()
      end, { desc = "Preview Hunk" } },
      { "<leader>gr", function()
        require("gitsigns").reset_hunk()
      end, { desc = "Reset Hunk" } },
      { "<leader>gR", function()
        require("gitsigns").reset_buffer()
      end, { desc = "Reset Buffer" } },
      { "<leader>gj", function()
        require("gitsigns").next_hunk({ navigation_message = false })
      end, { desc = "Next Hunk" } },
      {
        "<leader>gs", function()
          require("gitsigns").stage_hunk()
        end,
        { desc = "Stage Hunk" }
      },
      {
        "<leader>gu", function()
          require("gitsigns").undo_stage_hunk()
        end,
        { desc = "Undo Stage Hunk" }
      },
      {
        "<leader>go", require("telescope.builtin").git_status,
        { desc = "Open changed file" }
      },
      {
        "<leader>gb", require("telescope.builtin").git_branches,
        { desc = "Checkout branch" }
      },
      {
        "<leader>gc", require("telescope.builtin").git_commits,
        { desc = "Checkout commit" }
      },
      {
        "<leader>gC", require("telescope.builtin").git_bcommits,
        { desc = "Checkout commit(for current file)" }
      },
      {
        "<leader>gd", function()
          vim.cmd("Gitsigns diffthis HEAD")
        end,
        { desc = "Git Diff HEAD" }
      },
    }
  }, {}, opts)
end

return M
