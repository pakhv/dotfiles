vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = "main" },
})

-- require('nvim-treesitter').install { 'lua', 'c_sharp', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' }

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    if not vim.treesitter.language.add(language) then return end
    vim.treesitter.start(buf, language)

    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
