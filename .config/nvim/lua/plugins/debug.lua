return {
  { "nvim-neotest/nvim-nio" },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- -----------------------------
      -- Adapters
      -- -----------------------------

      -- Python (debugpy)
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          console = "integratedTerminal", -- better UX than internal console for many apps
          pythonPath = function()
            local conda_prefix = os.getenv("CONDA_PREFIX")
            if conda_prefix and conda_prefix ~= "" then
              return conda_prefix .. "/bin/python"
            end
            return "/usr/bin/python3"
          end,
          justMyCode = true,
        },
      }

      -- LLDB (C/C++)
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode",
        name = "lldb",
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
        },
      }
      dap.configurations.c = vim.deepcopy(dap.configurations.cpp)

      -- -----------------------------
      -- Ergonomic signs
      -- -----------------------------
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- -----------------------------
      -- DAP UI layout
      -- -- -----------------------------
      dapui.setup({
        controls = { enabled = true },
        floating = { border = "rounded" },

        layouts = {
          -- Left: "state" you constantly need while stepping
          {
            position = "left",
            size = 50, -- columns
            elements = {
              { id = "scopes", size = 0.45 },
              { id = "watches", size = 0.15 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.20 },
            },
          },
          -- Bottom: output / interaction
          {
            position = "bottom",
            size = 12, -- lines
            elements = {
              { id = "console", size = 0.60 },
              { id = "repl", size = 0.40 },
            },
          },
        },
      })

      -- -----------------------------
      -- Session lifecycle hooks
      -- -----------------------------
      -- "before" attach/launch ensures UI is ready when session starts
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- -----------------------------
      -- Keymaps
      -- -----------------------------
      local map = vim.keymap.set
      map("n", "<F5>", dap.continue, { desc = "DAP continue" })
      map("n", "<F10>", dap.step_over, { desc = "DAP step over" })
      map("n", "<F11>", dap.step_into, { desc = "DAP step into" })
      map("n", "<F12>", dap.step_out, { desc = "DAP step out" })

      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP breakpoint" })
      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP conditional breakpoint" })

      map("n", "<leader>dc", dap.run_to_cursor, { desc = "DAP run to cursor" })
      map("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
      map("n", "<leader>dl", dap.run_last, { desc = "DAP run last" })
      map("n", "<leader>dq", dap.terminate, { desc = "DAP terminate" })
      map("n", "<leader>du", dapui.toggle, { desc = "DAP UI toggle" })

      -- "More info" while debugging
      map({ "n", "v" }, "<leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "DAP hover" })

      map("n", "<leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, { desc = "DAP scopes (float)" })
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      commented = true, -- keeps inline values visually quieter
    },
  },
}

