vim.keymap.set('n', '<c-a>', require("harpoon.mark").add_file)
vim.keymap.set('n', '<leader>ui', require("harpoon.ui").toggle_quick_menu)
vim.keymap.set('n', '<leader>,', require("harpoon.ui").nav_prev)
vim.keymap.set('n', '<leader>.', require("harpoon.ui").nav_next)
