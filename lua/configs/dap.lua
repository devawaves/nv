local utils = require "custom_utils"
local M = {}

M.config = function()
  require("custom_utils").load_breakpoints()
  local dap = require "dap"
  -- dap.set_log_level "TRACE"

  ----------------------------------------------------
  --                    ADAPTERS                    --
  ----------------------------------------------------
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = "codelldb",
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.adapters.debugpy = {
    -- Requires:
    --  python -m pip install debugpy # --break-system-packages # <- if the first command doesn't work
    type = "executable",
    command = "python",
    -- function()
      --    local venv = os.getenv "VIRTUAL_ENV"
      --    if venv then
      --      return venv .. "/bin/python"
      --    else
      --      return "python" -- From $PATH
      --    end
      -- end,
      args = {
        "-m",
        "debugpy.adapter",
      },
    }

    -------------------------------------------------------
    --                    DAP CONFIGS                    --
    -------------------------------------------------------

    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = "debugpy",   -- the type here established the link to the adapter definition: `dap.adapters.debugpy`
        request = "launch",
        name = "Launch file",
        cwd = "${workspaceFolder}",

        program = "${file}",   -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return "/usr/bin/python"
          end
        end,
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
          -- First split it by spaces
          local raw = vim.fn.input "Args: "
          local home = os.getenv "HOME"
          local args_filtered = raw.gsub(raw, "~", home)
          local args = vim.split(args_filtered, " ")

          print "HERE:"
          vim.print(args)
          for i, arg in ipairs(args) do
            -- Replace ~ with $HOME
            print(arg)
          end
          vim.print(args)

          return args
        end,
      },
    }

    -- Reuse configurations for other languages
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          print "Building Project..."
          vim.cmd "!cargo build"
          print "Done!"

          -- local release_dir = vim.fn.finddir("target/release", vim.fn.getcwd() .. ";")
          local debug_dir = vim.fn.finddir("target/debug", vim.fn.getcwd() .. ";")

          -- If both are nil then run cargo build
          -- WARNING:
          -- if release_dir == "" and debug_dir == "" then
          --   print "Building Project..."
          --   vim.cmd "silent !cargo build"
          --   print "Built With Cargo"
          -- end

          -- Select binary by the (only) file that has no extension
          -- Get the directory path where your files are located
          --[[ release_dir or ]]
          local directory = debug_dir

          -- Get a list of files in the directory
          local files = vim.fn.readdir(directory)

          -- Iterate through the files
          for _, file in ipairs(files) do
            local filepath = directory .. "/" .. file

            -- Check if the file is executable
            local is_executable = vim.fn.executable(filepath) == 1

            if is_executable then
              print("Found Executable on: ", filepath)
              return filepath
              -- You can perform further actions on the executable here
            end
          end

          -- If none of the above don't work
          -- then ask the user to input the path to the executable
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,

        args = function()
          -- First split it by spaces
          local raw = vim.fn.input "Args: "
          local home = os.getenv "HOME"
          local args_filtered = raw.gsub(raw, "~", home)
          local args = vim.split(args_filtered, " ")

          print "HERE:"
          vim.print(args)
          for i, arg in ipairs(args) do
            -- Replace ~ with $HOME
            print(arg)
          end
          vim.print(args)

          return args
        end,
      },
    }

    -------------------------------------------------
    --                    SIGNS                    --
    -------------------------------------------------
    vim.fn.sign_define("DapBreakpoint", {
      text = " ",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpointLine",
      numhl = "DapBreakpointNum",
    })

    vim.fn.sign_define("DapLogPoint", {
      text = " ",
      texthl = "DapLogPoint",
      linehl = "DapLogPointLine",
      numhl = "DapLogPointNum",
    })

    vim.fn.sign_define("DapStopped", {
      text = " ",
      texthl = "DapStopped",
      linehl = "DapStoppedLine",
      numhl = "DapStoppedNum",
    })

    vim.fn.sign_define("DapBreakpointCondition", {
      text = " ",
      texthl = "DapBreakpointCondition",
      linehl = "DapBreakpointConditionLine",
      numhl = "DapBreakpointConditionNum",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = " ",
      texthl = "DapBreakpointRejected",
      linehl = "DapBreakpointRejectedLine",
      numhl = "DapBreakpointRejectedNum",
    })
end

M.keys = {
  {
    "<leader>dc",
    "<cmd>lua require('dap').continue()<CR>",
    mode = "n",
    desc = "Continue",
  },

  {
    "<leader>ds",
    "<cmd>lua require('dap').step_over()<CR>",
    mode = "n",
    desc = "Step Over",
  },

  {
    "<leader>di",
    "<cmd>lua require('dap').step_into()<CR>",
    mode = "n",
    desc = "Step Into",
  },

  {
    "<leader>do",
    "<cmd>lua require('dap').step_out()<CR>",
    mode = "n",
    desc = "Step Out",
  },

  {
    "<leader>db",
    function()
      -- require("persistent-breakpoints.api").toggle_breakpoint()
      require("dap").toggle_breakpoint()
      utils.store_breakpoints(false)
    end, -- Persist the breakpoints
    mode = "n",
    desc = "Toggle Breakpoint",
  },

  {
    "<leader>dB",
    function()
      -- require("persistent-breakpoints.api").set_conditional_breakpoint() -- Persist
      require("dap").toggle_breakpoint(vim.fn.input "Log: ")
      utils.store_breakpoints(false)
    end,
    mode = "n",
    desc = "Set Conditional Breakpoint",
  },

  {
    "<leader>dL",
    function()
      require("dap").toggle_breakpoint(nil, nil, vim.fn.input "Log point message: ")
      utils.store_breakpoints(false)
    end,
    mode = "n",
    desc = "Log Point",
  },

  {
    "<leader>dl",
    "<cmd>lua require('dap').run_last()<CR>",
    mode = "n",
    desc = "Run Last",
  },

  {
    "<leader>dr",
    "<cmd>lua require('dap').repl.open()<CR>",
    mode = "n",
    desc = "Open REPL",
  },

  {
    "<leader>dd",
    "<cmd>lua require('dapui').toggle()<CR>",
    mode = "n",
    desc = "Toggle UI",
  },

  {
    "<leader>da",
    "<cmd>lua require('dapui').eval()<CR>",
    mode = "n",
    desc = "Evaluate",
  },

  {
    "<leader>du",
    "<cmd>lua require('dapui').scopes()<CR>",
    mode = "n",
    desc = "Scopes",
  },

  {
    "<leader>dv",
    "<cmd>lua require('dapui').variables()<CR>",
    mode = "n",
    desc = "Variables",
  },

  {
    "<leader>dw",
    "<cmd>lua require('dapui').watches()<CR>",
    mode = "n",
    desc = "Watches",
  },

  {
    "<leader>de",
    "<cmd>lua require('dapui').set_exception_breakpoints()<CR>",
    mode = "n",
    desc = "Exception Breakpoints",
  },

  {
    "<leader>di",
    "<cmd>lua require('dapui').pick_one()<CR>",
    mode = "n",
    desc = "Pick One",
  },

  { -- NOTE: Log Points are not persistent right now.
    "<leader>dj",
    function()
      require("dap").toggle_breakpoint(vim.fn.input "Log: ")
    end,
    mode = "n",
    desc = "Set Log Point",
  },

  {
    "<leader>dx",
    function()
      -- require("persistent-breakpoints.api").clear_all_breakpoints()
      require("dap").clear_breakpoints()
      utils.store_breakpoints(true)
    end,
    mode = "n",
    desc = "Clear Breakpoints",
  },

  {
    "<leader>dg",
    function()
      require("dap").list_breakpoints(0)
    end,
    mode = "n",
    desc = "Set REPL Highlight",
  },
}

return M
