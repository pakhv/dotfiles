local opt = vim.o

opt.termguicolors = true
opt.winborder = "rounded"
opt.swapfile = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
opt.backup = false

opt.hlsearch = false

opt.mouse = 'a'
opt.clipboard = 'unnamedplus'

opt.breakindent = true

opt.undofile = true

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 250
opt.timeoutlen = 300

opt.completeopt = 'menuone,noselect'
opt.scrolloff = 999

opt.shiftwidth = 4
opt.expandtab = true

opt.statusline =
"%<%f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%{% luaeval('(package.loaded[''vim.diagnostic''] and #vim.diagnostic.count() ~= 0 and vim.diagnostic.status() .. '' '') or '''' ') %} [%{&fenc!=''?&fenc:&enc}%{(&bomb?',B':'')}] %y %{% &ruler ? ( &rulerformat == '' ? '%-14.(%l:%c%V%) %P' : &rulerformat ) : '' %}"
