-- Set up MDX filetype detection
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

-- Configure Treesitter to treat MDX as markdown with embedded JSX
local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
if status_ok then
  treesitter_config.setup({
    highlight = {
      additional_vim_regex_highlighting = { "mdx" },
    },
  })
end

-- Set up MDX as a composite filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "mdx",
  callback = function()
    -- Set treesitter parser for markdown
    vim.treesitter.start(0, "markdown")
    
    -- Enable JSX/TSX highlighting for components and expressions
    vim.cmd([[
      set syntax=markdown
      syn include @tsx syntax/typescriptreact.vim
      syn region mdxJsxBlock start=/{/ end=/}/ contains=@tsx containedin=ALL
      syn region mdxJsxElement start=/<[A-Z]/ end=/>/ contains=@tsx containedin=ALL
      syn region mdxJsxElement start=/<[a-z][^>]*>/ end=/<\/[a-z][^>]*>/ contains=@tsx containedin=ALL
      syn region mdxImport start=/^import/ end=/$/ contains=@tsx
      syn region mdxExport start=/^export/ end=/$/ contains=@tsx
    ]])
    
    -- Set proper indentation and formatting
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    
    -- Set commentstring for proper commenting
    vim.bo.commentstring = "{/* %s */}"
  end,
})