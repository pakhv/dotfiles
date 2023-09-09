require("toggleterm").setup{
  shell = 'zsh',
  direction = 'horizontal',
  hidden = true,
  auto_scroll = true,
  start_in_insert = true,
  open_mapping = [[<c-\>]]
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", direction = 'float' })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
