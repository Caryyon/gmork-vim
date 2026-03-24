
return {
  root_dir = require("lspconfig").util.root_pattern("package.json"),
  single_file_support = false,
  settings = {
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },  -- Only run on TypeScript files
    javascript = {
      suggest = false
    }
  }
}
