vim.keymap.set('n', '<a-a>', require("harpoon.mark").add_file)
vim.keymap.set('n', '<leader>ui', require("harpoon.ui").toggle_quick_menu)
vim.keymap.set('n', '<a-,>', require("harpoon.ui").nav_prev)
vim.keymap.set('n', '<a-.>', require("harpoon.ui").nav_next)


vim.keymap.set('n', '<a-t>', function()
  local last_tmux_window = vim.fn.system("tmux list-windows -F '#I' | tail -1")
  local last_tmux_window_num = tonumber(last_tmux_window)

  if (last_tmux_window_num == nil) then
    print('Couldn\'t parse tmux window number')
    return
  end

  local new_tmux_window = last_tmux_window_num + 1
  require("harpoon.tmux").sendCommand(new_tmux_window, "fd\n")
end)
