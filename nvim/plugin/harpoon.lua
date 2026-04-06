vim.pack.add({
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
})

local harpoon = require("harpoon")

harpoon:setup({
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true
  }
})

vim.keymap.set("n", "<a-a>", function() harpoon:list():add() end)
vim.keymap.set("n", "<a-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<a-,>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<a-.>", function() harpoon:list():next() end)
