local dap = require('dap')
local Terminal  = require('toggleterm.terminal').Terminal

vim.api.nvim_create_user_command("DebugDotnetTests", function (args)
  local current_win = vim.api.nvim_get_current_win()

  local command = "export VSTEST_HOST_DEBUG=1 && dotnet test"
  local filter_args = args['args']

  if (filter_args and filter_args ~= '') then
    command = command .. " --filter " .. filter_args
  end

  local process_is_ready = false
  local pid_pattern = "Process Id: (%d+), Name: dotnet"

  local debug_dotnet_tests = Terminal:new({
    cmd = command,
    close_on_exit = false,
    direction = 'horizontal',
    auto_scroll = true,
    on_create = function (_)
      vim.cmd('stopinsert')
      vim.api.nvim_set_current_win(current_win)
    end,
    on_stdout = function(_, _, data, _)
      if (process_is_ready) then
        return
      end

      for _, str in ipairs(data) do
        local _, _, pid = str:find(pid_pattern)

        if (pid) then

          process_is_ready = true

          dap.run({
            name = "tmp_attach_to_tests",
            type = "coreclr",
            request = "attach",
            processId = pid
          }, {})
        end
      end
    end
  })

  debug_dotnet_tests:toggle()
end, {})

local ts_utils = require 'nvim-treesitter.ts_utils'

vim.api.nvim_create_user_command("TSTest", function (args)
  print(require('nvim-treesitter').statusline({
    indicator_size = 500,
    type_patterns = {'namespace', 'class', 'identifier'},
    allow_dublicates = true
  }))
end, {})
