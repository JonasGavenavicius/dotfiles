local M = {
    'mfussenegger/nvim-dap',
    dependencies = {
      "leoluz/nvim-dap-go",
      "suketa/nvim-dap-ruby",
      "theHamsta/nvim-dap-virtual-text"
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

    require("dap-ruby").setup()

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

    dap.adapters.go = {
      type = "executable",
      command = "node",
      args = { "go-debug-adapter" },
    }

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        showLog = true,
        program = "${file}",
        dlvToolPath = vim.fn.exepath "dlv",
      },
    }

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
          -- Ask user for path to binary
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }


    local map = vim.keymap.set
    map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
    map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
    map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
    map("n", "<Leader>dc>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
    map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
    map("n", "<Leader>dd", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debugger set conditional breakpoint" })
    map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
    map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

    require("dap-go").setup()
    require("nvim-dap-virtual-text").setup({})
  end,
}

M.keys = function()
  return {
    { "<F5>", require("dap").continue },
    { "<F6>", require("dap").terminate },
    { "<F2>", require("dap").step_into },
    { "<F3>", require("dap").step_over },
    { "<F4>", require("dap").step_out },
    { "<leader>db", require("dap").toggle_breakpoint },
  }
end
return M
