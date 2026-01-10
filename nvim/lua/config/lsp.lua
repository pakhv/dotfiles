vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "clangd",
})

vim.diagnostic.config {
  float = { border = 'rounded' },
  virtual_text = true,
}
