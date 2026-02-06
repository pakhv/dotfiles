vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.pick' },
})

local pick = require('mini.pick')
pick.setup({
  mappings = { choose = '<C-y>', choose_marked = '<C-q>' },
})

vim.keymap.set('n', '<leader>gf', function() pick.builtin.files({ tool = 'git' }) end)
vim.keymap.set('n', '<leader>sf', function() pick.builtin.cli({ command = { 'find', '.', '-type', 'f' } }) end)
vim.keymap.set('n', '<leader>sg', pick.builtin.grep_live)
vim.keymap.set('n', '<leader>sh', pick.builtin.help)
vim.keymap.set('n', '<leader><leader>', pick.builtin.buffers)
