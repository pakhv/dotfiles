return {
  {
    {
      'mfussenegger/nvim-dap',
      config = function()
        local dap = require('dap')

        dap.adapters.coreclr = {
          type = 'executable',
          command = '/root/.local/share/nvim/mason/packages/netcoredbg/netcoredbg',
          args = { '--interpreter=vscode' },
        }

        dap.configurations.cs = {
          {
            type = "coreclr",
            name = "Attach",
            request = "attach",
            processId = function()
              return vim.fn.input({ prompt = 'Enter Process Id: ' })
            end
          },
          {
            type = "coreclr",
            name = "Launch Docflow",
            request = "launch",
            program = "/workspaces/dev-environment/backends/api-docflow/src/Docflow.API/bin/Debug/net8.0/Docflow.API.dll"
          }
        }

        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F9>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })

        local dapui = require 'dapui'
        dapui.setup {
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
          layouts = {
            {
              elements = {
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
              },
              size = 40, -- 40 columns
              position = "left",
            },
            {
              elements = {
                "repl",
                "console",
              },
              size = 0.25, -- 25% of total lines
              position = "bottom",
            },
          },
          floating = {
            max_height = nil,  -- These can be integers or a float between 0 and 1.
            max_width = nil,   -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
              close = { "q", "<Esc>" },
            },
          },
          windows = { indent = 1 },
          render = {
            max_type_length = nil, -- Can be integer or nil.
            max_value_lines = 100, -- Can be integer or nil.
          }
        }

        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
        vim.keymap.set('n', '<F8>', function() dapui.toggle({ reset = true }) end,
          { desc = 'Debug: See last session result.' })
        vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'Debug: Eval expression' })
      end
    },
    'rcarriga/nvim-dap-ui',
  }
}
