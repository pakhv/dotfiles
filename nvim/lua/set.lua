vim.opt.termguicolors = true
vim.opt.winborder = "rounded"

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.relativenumber = true
vim.opt.backup = false

vim.o.hlsearch = false

vim.wo.number = true

vim.o.mouse = 'a'

vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect'
vim.o.scrolloff = 999

vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.o.statusline =
"%<%f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%{% luaeval('(package.loaded[''vim.diagnostic''] and #vim.diagnostic.count() ~= 0 and vim.diagnostic.status() .. '' '') or '''' ') %} %{&fenc!=''?&fenc:&enc}%{(&bomb?',B':'')} %y %{% &ruler ? ( &rulerformat == '' ? '%-14.(%l:%c%V%) %P' : &rulerformat ) : '' %}"
