vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
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
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

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
