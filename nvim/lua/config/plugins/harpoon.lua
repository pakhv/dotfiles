return {
  {
    'ThePrimeagen/harpoon',
    config = function()
      vim.keymap.set('n', '<a-a>', require("harpoon.mark").add_file)
      vim.keymap.set('n', '<leader>ui', require("harpoon.ui").toggle_quick_menu)
      vim.keymap.set('n', '<a-,>', require("harpoon.ui").nav_prev)
      vim.keymap.set('n', '<a-.>', require("harpoon.ui").nav_next)
    end
  }
}
