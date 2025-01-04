-- commands.lua
local core = require("jollama.core")

local M = {}

M.setup = function()
  -- Set up a key binding for <leader>j to trigger the function
  vim.api.nvim_set_keymap(
    'v',
    '<leader>j',
    ':lua require("jollama.core").process_selection_with_input()<CR>',
    { noremap = true, silent = true }
  )
end

return M
