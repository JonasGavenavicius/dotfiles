local M = {
  'mfussenegger/nvim-dap',
  dependencies = {
    "leoluz/nvim-dap-go",
    "suketa/nvim-dap-ruby",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui"
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    -- Setup plugins
    dapui.setup()
    require("dap-go").setup()
    require("dap-ruby").setup()
    require("nvim-dap-virtual-text").setup({})

    -- UI open/close logic
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- Ruby adapter + config
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

    -- Go configuration (adapter handled by dap-go)
    dap.configurations.go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        showLog = true,
        program = "${file}",
        dlvToolPath = vim.fn.exepath("dlv"),
      },
    }

    -- Rust (codelldb)
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      }
    }

    dap.configurations.rust = {
      {
        name = "Debug Rust",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,
}

M.keys = function()
  return {
    { "<F2>", function() require("dap").step_into() end, desc = "DAP step into" },
    { "<F3>", function() require("dap").step_over() end, desc = "DAP step over" },
    { "<F4>", function() require("dap").step_out() end, desc = "DAP step out" },
    { "<F5>", function() require("dap").continue() end, desc = "DAP continue" },
    { "<F6>", function() require("dap").terminate() end, desc = "DAP terminate" },
    { "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<Leader>dd", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
    { "<Leader>dr", function() require("dap").run_last() end, desc = "Run last" },
  }
end

return M
