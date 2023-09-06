local dap      = require('dap')
local Terminal = require('toggleterm.terminal').Terminal

local function debug_dotnet_tests(filter_args)
  local command = "export VSTEST_HOST_DEBUG=1 && dotnet test"

  if (filter_args and filter_args ~= '') then
    command = command .. " --filter " .. filter_args
  end

  local process_is_ready = false
  local pid_pattern = "Process Id: (%d+), Name: dotnet"
  local current_win = vim.api.nvim_get_current_win()

  local term = Terminal:new({
    cmd = command,
    close_on_exit = false,
    direction = 'horizontal',
    auto_scroll = true,
    on_create = function(_)
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

  term:toggle()
end

local function run_dotnet_tests(filter_args)
  local command = 'dotnet test'

  if (filter_args and filter_args ~= '') then
    command = command .. " --filter " .. filter_args
  end

  local term = Terminal:new({
    cmd = command,
    direction = 'horizontal',
    auto_scroll = true,
    close_on_exit = false
  })

  term:toggle()
end

local function transform(line)
  return line:gsub("%s*[%[%(%{]*%s*$", "")
end

local function find_method_name()
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()

  while node do
    if (node and node:parent() and node:parent():type() == 'method_declaration') then
      local method_declaration_node = node:parent()

      local children_nodes = {}

      for i = 0, method_declaration_node:child_count() - 1, 1 do
        children_nodes[i + 1] = method_declaration_node:child(i)
      end

      for _, child in ipairs(children_nodes) do
        local node_name = ts_utils._get_line_for_node(child, { 'identifier' }, transform, 0)

        if (node_name and node_name ~= '') then
          return node_name
        end
      end
    end

    node = node:parent()
  end
end

local function get_dotnet_tests_filter()
  local status = require('nvim-treesitter').statusline({
    indicator_size = 500,
    type_patterns = { 'namespace', 'class', 'identifier' },
    allow_dublicates = true
  })

  local parts = {}
  for match in (status or ''):gmatch('([^->]+)') do
    match, _ = match:gsub('^%s*(.-)%s*$', '%1')
    table.insert(parts, match)
  end

  local namespaceLine, classLine, _ = unpack(parts)

  local _, _, namespace = (namespaceLine or ''):find("namespace ([%a%.]+)")
  local _, _, class = (classLine or ''):find("%a class (%a+)")

  if (namespace == nil or class == nil) then
    return
  end

  local resultFilter = namespace .. '.' .. class

  local method = find_method_name()

  if (method) then
    resultFilter = resultFilter .. '.' .. method
  end

  return resultFilter
end

vim.api.nvim_create_user_command("TSTest", function(_)
  local filter_args = get_dotnet_tests_filter()

  if (filter_args and filter_args ~= '') then
    print('Filter: ' .. filter_args)
  end

  print('1. Run Tests With Filter Applied')
  print('2. Debug Tests With Filter Applied')
  print('3. Run All Tests')
  print('4. Debug All Tests')
  local user_choice = vim.fn.input('Please enter number.. ')

  if (user_choice ~= '1'
        and user_choice ~= '2'
        and user_choice ~= '3'
        and user_choice ~= '4') then
    print('OMEGALUL')
    return
  end

  if (user_choice == '3' or user_choice == '4') then
    filter_args = ''
  end

  if (user_choice == '2' or user_choice == '4') then
    debug_dotnet_tests(filter_args)
  else
    run_dotnet_tests(filter_args)
  end
end, {})
