-- Set up DAP

return {
  --nvim-nio dependency
  { "nvim-neotest/nvim-nio" },

  -- Main nvim-dap plugin
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Configure Python
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" }
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            -- set path to python interprtere (conda or system-wide)
            local conda_prefix = os.getenv("CONDA_PREFIX")
            if conda_prefix then
              return conda_prefix .. "/bin/python"
            else
              return "/usr/bin/python3"
            end
          end,
        },
      }

      -- Configuration for C/C++ using lldb
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- Path to lldb-vscode executable
        name = "lldb"
      }

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,

          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},

          -- Set environment variables if needed
          env = function()
            local variables = {}
            -- Example: variables["MY_ENV_VAR"] = "value"
            return variables
          end,

          -- LLDB specific options
          initCommands = function()
            return {}
          end,
        },
      }

      -- Duplicate C++ configuration for C as well
      dap.configurations.c = vim.deepcopy(dap.configurations.cpp)
    end,
  },

  -- nvim-dap-ui for a visual debugging interface
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      -- Use pcall to ensure the module loads without errors
      local ok, dapui = pcall(require, "dapui")
      if ok then
        dapui.setup()
        local dap = require("dap")
        -- Automatically open and close the dap-ui interface on session events
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
      else
        print("Failed to load dapui")
      end
    end,
  },
  -- nvim-dap-virtual-text for inline debugging information
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
