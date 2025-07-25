local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "suketa/nvim-dap-ruby",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup plugins
    require("nvim-dap-virtual-text").setup({})
    dapui.setup()
    require("dap-go").setup()
    require("dap-ruby").setup()

    -- DAP UI auto open/close
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- Ruby adapter
    dap.adapters.ruby = {
      type = "executable",
      command = "readapt",
      args = { "stdio" },
    }

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "Debug RSpec current file",
        request = "launch",
        program = "${file}",
        useBundler = true,
      },
    }

    -- Rust adapter (codelldb via Mason)
    local mason_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = mason_path,
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.rust = {
      {
        name = "Debug Rust",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
  end,
}

M.keys = function()
  return {
    { "<F2>",        function() require("dap").step_into() end,                                 desc = "DAP step into" },
    { "<F3>",        function() require("dap").step_over() end,                                 desc = "DAP step over" },
    { "<F4>",        function() require("dap").step_out() end,                                  desc = "DAP step out" },
    { "<F5>",        function() require("dap").continue() end,                                  desc = "DAP continue" },
    { "<F6>",        function() require("dap").terminate() end,                                 desc = "DAP terminate" },
    { "<Leader>db",  function() require("dap").toggle_breakpoint() end,                         desc = "Toggle breakpoint" },
    { "<Leader>dd",  function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
    { "<Leader>dlr", function() require("dap").run_last() end,                                  desc = "Run last" },
    { "<Leader>du",  function() require("dapui").toggle() end,                                  desc = "Toggle DAP UI" },
    { "<Leader>de",  function() require("dap").repl.open() end,                                 desc = "Open DAP REPL" },
    { "<Leader>dlc", function() require("dap").run_to_cursor() end,                             desc = "Run to cursor" },
  }
end

return M
