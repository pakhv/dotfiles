vim.api.nvim_create_user_command('TsRenameFile', function(_)
  local filetype = vim.bo.filetype

  if (filetype ~= 'typescript'
        and filetype ~= 'typescriptreact'
        and filetype ~= 'javascript'
        and filetype ~= 'javascriptreact'
      ) then
    print 'Invalid filetype'
    return
  end

  local current_buf_path = vim.api.nvim_buf_get_name(0)
  local new_buf_path = vim.fn.input({ prompt = 'New file path: ', default = current_buf_path })

  vim.fn.mkdir(vim.fn.fnamemodify(new_buf_path, ":p:h"), "p")

  vim.lsp.buf_request(0,
    'workspace/executeCommand',
    {
      command = '_typescript.applyRenameFile',
      arguments = { {
        sourceUri = current_buf_path,
        targetUri = new_buf_path
      } }
    },
    function(err, _, _, _)
      if (err) then
        print(err.message)
        return
      end

      local success, _, err_msg = vim.loop.fs_rename(current_buf_path, new_buf_path)

      if (not success) then
        print(err_msg)
        return
      end

      vim.schedule(function()
        vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), { force = true })

        local new_bufnr = vim.fn.bufadd(new_buf_path);
        vim.api.nvim_set_current_buf(new_bufnr)

        print 'Don\'t forget to save buffers...'
      end)
    end)
end, {})
