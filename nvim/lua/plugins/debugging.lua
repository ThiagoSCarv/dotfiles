-- plugins/dap.lua
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/dap_adapters/codelldb/extension/adapter/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name = "Launch C with codelldb",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.cpp = dap.configurations.c

      -- Keymaps básicos
      vim.keymap.set("n", "<F1>", require("dap").continue, { desc = "Iniciar Debug" })
      vim.keymap.set("n", "<F2>", require("dap").step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<F3>", require("dap").step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<F4>", require("dap").step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint, { desc = "Breakpoint" })
    end,
  },
}
