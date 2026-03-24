-- Previous themes (backed up)
-- local colorscheme = "tokyonight-night"
-- local colorscheme = "dracula"

-- Gmork theme - inspired by the black wolf from The Neverending Story
local colorscheme = "gmork"

-- Set background first
vim.o.background = "dark"

-- Try to load the Lua version first
local status_ok, gmork = pcall(require, "colors.gmork")
if status_ok then
  -- Call setup function directly
  gmork.setup()
  vim.g.colors_name = "gmork"
else
  -- Try vim colorscheme command
  local vim_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not vim_status_ok then
    -- Try the theme variant
    local theme_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme .. "-theme")
    if not theme_status_ok then
      -- Final fallback
      pcall(vim.cmd, "colorscheme default")
      vim.notify("Gmork colorscheme not found, using default", vim.log.levels.WARN)
    end
  end
end
