local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "gmork.lsp.mason"
require("gmork.lsp.handlers").setup()
require "gmork.lsp.null-ls"
