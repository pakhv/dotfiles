-- [[ Basic Keymaps ]]
local opts = { noremap = true, silent = true }

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)
vim.keymap.set('i', 'jk', '<ESC>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = -1, float = false } end,
  { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = 1, float = false } end,
  { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>td', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostics list' })

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<leader>e", ":Oil<cr>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Better replace
vim.keymap.set("v", "p", '"_dP', opts)

-- Quickfix list
vim.keymap.set('n', '[q', ':cprev<cr>', { desc = 'go to previous quickfix list entry' })
vim.keymap.set('n', ']q', ':cnext<cr>', { desc = 'go to next quickfix list entry' })
