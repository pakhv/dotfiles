-- DAP config
local dap = require('dap')

dap.adapters.coreclr = {
  type = 'executable',
  command = '/usr/local/bin/netcoredbg',
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
-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
dapui.setup {
  -- Set icons to characters that are more likely to work in every terminal.
  --    Feel free to remove or use ones that you like more! :)
  --    Don't feel like these are good choices.
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
        -- Elements can be strings or table with id and size keys.
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

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
vim.keymap.set('n', '<F8>', function() dapui.toggle({ reset = true }) end, { desc = 'Debug: See last session result.' })
vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'Debug: Eval expression' })

--dap.listeners.after.event_initialized['dapui_config'] = dapui.open
--dap.listeners.before.event_terminated['dapui_config'] = dapui.close
--dap.listeners.before.event_exited['dapui_config'] = dapui.close

local function get_launch_json_path()
  local default_path = vim.fn.getcwd() .. '/'
  local json_dir = vim.fn.input({ prompt = 'Enter launch.json directory: ', default = default_path })

  if json_dir.match('.+/$', 1) ~= nil then
    json_dir = json_dir.sub(1, json_dir.len - 1)
  end

  json_dir = json_dir .. '/launch.json'

  return json_dir
end

vim.api.nvim_create_user_command("DapAddCSharpLaunchJsonConfiguration", function()
  local json_dir = get_launch_json_path()
  require('dap.ext.vscode').load_launchjs(json_dir, { coreclr = { 'cs' } })
end, {})
