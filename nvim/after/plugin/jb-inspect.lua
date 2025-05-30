local function run_async(cmd, on_exit)
  local job_id = vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, data, event)
      if data > 0 then
        print('Command failed with exit code: ' .. data, vim.log.levels.ERROR)
      else
        if on_exit then on_exit(event) end
      end
    end
  })
  return job_id
end

vim.api.nvim_create_user_command('JbInspect', function(_)
  local filetype = vim.bo.filetype

  if (filetype ~= 'cs') then
    print 'Invalid filetype'
    return
  end

  local cs_projs = vim.fn.system('find "$(pwd)" -type f -name "*.csproj"')
  local current_buf_path = vim.api.nvim_buf_get_name(0)
  local current_project_path = nil
  local buf_rel_path = nil

  for s in cs_projs:gmatch("[^\r\n]+") do
    local path = vim.fs.dirname(s)
    buf_rel_path = vim.fs.relpath(path, current_buf_path)

    if (buf_rel_path ~= nil) then
      current_project_path = s
      break
    end
  end

  if (current_project_path == nil) then
    print 'Couldn\'t find csproj file'
    return
  end

  local command = 'jb inspectcode ' ..
      current_project_path .. ' -o="jbinspect/output.json" --include="' .. buf_rel_path .. '"'

  print('Command: ' .. command)

  run_async(command, function()
    print 'jb inspect done!'
  end)
end, {})
