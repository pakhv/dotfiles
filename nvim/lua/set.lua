vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

local opt = vim.o

opt.termguicolors = true
opt.winborder = "rounded"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.hlsearch = false
opt.mouse = 'a'
opt.inccommand = "split"
opt.confirm = true;
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = 'menuone,noselect'
opt.scrolloff = 999
opt.shiftwidth = 4
opt.expandtab = true
opt.statusline =
"%<%f %h%w%m%r %{% v:lua.require('vim._core.util').term_exitcode() %}%=%{% luaeval('(package.loaded[''vim.ui''] and vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin or -1) and vim.ui.progress_status()) or '''' ')%}%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%{% luaeval('(package.loaded[''vim.diagnostic''] and next(vim.diagnostic.count()) and vim.diagnostic.status() .. '' '') or '''' ') %} [%{&fenc!=''?&fenc:&enc}%{(&bomb?',B':'')}] %y %{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}"

if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = 'win32yank-wsl',
        copy = {
            ['+'] = 'win32yank.exe -i --crlf',
            ['*'] = 'win32yank.exe -i --crlf',
        },
        paste = {
            ['+'] = 'win32yank.exe -o --lf',
            ['*'] = 'win32yank.exe -o --lf',
        },
        cache_enabled = 0,
    }
end
opt.clipboard = "unnamedplus"

opt.wildmode = "noselect"
vim.o.findfunc = function(cmdarg, _)
    local files = vim.fn.glob(
        "`find . -path \"**/node_modules\" -prune -o -path \"**/.git\" -prune -o -path \"**/bin\" -prune -o -path \"**/Debug\" -prune -o -type f -print`",
        false,
        true)

    return vim.fn.matchfuzzy(files, cmdarg)
end
