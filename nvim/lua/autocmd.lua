vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

local format_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end,
  group = format_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
  callback = function(event)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func,
        { buffer = event.buf, desc = desc })
    end

    nmap('<F2>', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('<leader>r', vim.lsp.buf.references,
      'Add lsp [R]eferences to quickfix list')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gr', require('telescope.builtin').lsp_references,
      '[G]oto [R]eferences')

    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,
      '[D]ocument [S]ymbols')

    nmap('K', function() vim.lsp.buf.hover {} end,
      'Hover Documentation')
    vim.keymap.set({ 'i' }, '<C-s>',
      function() vim.lsp.buf.signature_help {} end,
      { desc = 'Signature Documentation', buffer = event.buf })
  end
})

local pack_hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind

  if name == 'LuaSnip' and (kind == 'install' or kind == 'update') then
    vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path })
  end

  if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
    vim.system({ 'make' }, { cwd = ev.data.path })
  end

  if name == 'nvim-treesitter/nvim-treesitter' and (kind == 'install' or kind == 'update') then
    vim.api.nvim_exec_autocmds('User', { pattern = 'TSUpdate' })
  end
end

vim.api.nvim_create_autocmd('PackChanged', { callback = pack_hooks })
