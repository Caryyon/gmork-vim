-- Custom commands for Gmork theme
local M = {}

-- Function to reload the Gmork colorscheme
function M.reload_gmork()
  -- Clear existing highlights
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  
  -- Set background
  vim.o.background = "dark"
  
  -- Load the gmork colorscheme
  local status_ok, gmork = pcall(require, "colors.gmork")
  if status_ok then
    -- Force reload the module
    package.loaded["colors.gmork"] = nil
    gmork = require("colors.gmork")
    gmork.setup()
    vim.g.colors_name = "gmork"
    print("🐺 Gmork colorscheme reloaded!")
  else
    print("❌ Failed to load Gmork colorscheme")
  end
end

-- Create command
vim.api.nvim_create_user_command("GmorkReload", M.reload_gmork, {
  desc = "Reload the Gmork colorscheme"
})

-- Auto-reload on file change (for development)
local group = vim.api.nvim_create_augroup("GmorkReload", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*/colors/gmork.lua",
  callback = function()
    M.reload_gmork()
  end,
})

return M