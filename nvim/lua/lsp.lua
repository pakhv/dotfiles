vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "clangd",
  "roslyn_ls"
})

vim.diagnostic.config {
  virtual_text = true,
}
