local function on_list(what)
  vim.fn.setqflist({}, ' ', what)
  if
      #what.items == 1
      and what.context.method ~= 'textDocument/references'
  then
    vim.cmd('cfirst')
  else
    vim.cmd('botright copen')
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.hl_op()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end,
  group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true }),
  pattern = '*',
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
  callback = function(ev)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func,
        { buffer = ev.buf, desc = desc })
    end

    nmap('<F2>', vim.lsp.buf.rename, '[R]ename')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('<leader>r', vim.lsp.buf.references,
      'Add lsp [R]eferences to quickfix list')
    nmap('gI', function() vim.lsp.buf.implementation({ on_list = on_list }) end, '[G]oto [I]mplementation')

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return;
    end

    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == 'LuaSnip' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path })
    end

    if name == 'nvim-treesitter/nvim-treesitter' and (kind == 'install' or kind == 'update') then
      vim.cmd('TSUpdate')
    end
  end
})

vim.api.nvim_create_user_command('ToggleTerm', function(_)
  local opened_term_buf = nil
  local new_buf_created = false

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
      opened_term_buf = buf
      break
    end
  end

  if opened_term_buf ~= nil and #vim.fn.win_findbuf(opened_term_buf) > 0 then
    vim.api.nvim_win_close(vim.fn.win_findbuf(opened_term_buf)[1], false)
    return
  end

  if opened_term_buf == nil then
    opened_term_buf = vim.api.nvim_create_buf(true, false)
    new_buf_created = true
  end

  vim.api.nvim_open_win(opened_term_buf, true, { split = "below", height = 15 })

  if new_buf_created then
    vim.api.nvim_command(':terminal')
  end

  vim.api.nvim_command(':norm i')
end)

vim.api.nvim_create_autocmd('CmdlineChanged', {
  pattern = ":",
  callback = function()
    if string.sub(vim.fn.getcmdline(), 1, 5) == 'find ' then
      vim.fn.wildtrigger()
    end
  end
})

vim.api.nvim_create_user_command('Rg', function(opts)
  local pattern = opts.args
  if pattern == "" then
    return
  end

  local cmd = string.format("rg --vimgrep --smart-case %q", pattern)

  local output = vim.fn.systemlist(cmd)

  vim.fn.setqflist({}, "r", { title = "Ripgrep: " .. pattern, lines = output })

  local qf_list = vim.fn.getqflist()
  local match_count = #qf_list

  if match_count > 1 then
    vim.cmd("copen")
  elseif match_count == 1 then
    vim.cmd("cfirst")
  end
end, { nargs = 1 })
