-- MDX Live Preview Configuration
local M = {}

-- Configure markdown-preview.nvim for MDX files
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_open_ip = ''
vim.g.mkdp_browser = ''
vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_browserfunc = ''
vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 0,
  sync_scroll_type = 'middle',
  hide_yaml_meta = 1,
  sequence_diagrams = {},
  flowchart_diagrams = {},
  content_editable = false,
  disable_filename = 0,
  toc = {}
}
vim.g.mkdp_markdown_css = ''
vim.g.mkdp_highlight_css = ''
vim.g.mkdp_port = ''
vim.g.mkdp_page_title = '「${name}」'
vim.g.mkdp_filetypes = {'markdown', 'mdx'}

-- Custom MDX preview function
function M.preview_mdx()
  local filetype = vim.bo.filetype
  
  if filetype == "mdx" or filetype == "markdown" then
    -- For MDX files, we need to handle JSX components
    if filetype == "mdx" then
      -- Create a temporary markdown file without JSX for preview
      local current_file = vim.fn.expand("%:p")
      local temp_file = vim.fn.tempname() .. ".md"
      
      -- Read current buffer content
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local md_lines = {}
      
      for _, line in ipairs(lines) do
        -- Simple MDX to Markdown conversion
        -- Remove import statements
        if not line:match("^import ") then
          -- Convert JSX components to markdown
          line = line:gsub("<([A-Z][%w]*)[^>]*>", "**%1**")
          line = line:gsub("</[A-Z][%w]*>", "")
          -- Convert JSX expressions to code
          line = line:gsub("{([^}]+)}", "`%1`")
          table.insert(md_lines, line)
        end
      end
      
      -- Write temporary file
      local temp_handle = io.open(temp_file, "w")
      if temp_handle then
        temp_handle:write(table.concat(md_lines, "\n"))
        temp_handle:close()
        
        -- Open preview with temp file
        vim.cmd("MarkdownPreview " .. temp_file)
        
        -- Clean up temp file after a delay
        vim.defer_fn(function()
          vim.fn.delete(temp_file)
        end, 1000)
      end
    else
      -- Regular markdown preview
      vim.cmd("MarkdownPreview")
    end
  else
    print("Not a markdown or MDX file")
  end
end

-- Function to toggle MDX preview
function M.toggle_mdx_preview()
  local filetype = vim.bo.filetype
  
  if filetype == "mdx" or filetype == "markdown" then
    vim.cmd("MarkdownPreviewToggle")
  else
    print("Not a markdown or MDX file")
  end
end

-- Function to stop MDX preview
function M.stop_mdx_preview()
  vim.cmd("MarkdownPreviewStop")
end

-- Auto-commands for MDX files
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"markdown", "mdx"},
  callback = function()
    -- Set up buffer-local keymaps for preview
    local opts = { buffer = true, silent = true }
    vim.keymap.set("n", "<leader>mp", M.preview_mdx, opts)
    vim.keymap.set("n", "<leader>mt", M.toggle_mdx_preview, opts)
    vim.keymap.set("n", "<leader>ms", M.stop_mdx_preview, opts)
  end,
})

-- Split window MDX editing setup
function M.setup_mdx_split()
  local current_buf = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(current_buf, "filetype")
  
  if filetype == "mdx" or filetype == "markdown" then
    -- Split window vertically
    vim.cmd("vsplit")
    
    -- Start preview in the right window
    M.preview_mdx()
    
    -- Move back to the left window
    vim.cmd("wincmd h")
    
    print("MDX split editing mode activated")
  else
    print("Not a markdown or MDX file")
  end
end

-- Make functions available globally
_G.MdxPreview = M

return M