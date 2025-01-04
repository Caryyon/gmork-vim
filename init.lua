vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Automatically set up LuaRocks paths for future installations
local function setup_luarocks_paths()
    local has_luarocks, _ = pcall(require, "luarocks.loader")
    if has_luarocks then
        -- LuaRocks will automatically handle setting up the paths
        print("LuaRocks paths have been set up.")
    else
        -- Manually add paths if luarocks.loader is not found
        local luarocks_path = "/Users/cwolff/.luarocks"  -- Adjust to your actual path

        package.path = package.path .. ';' .. luarocks_path .. '/share/lua/5.1/?.lua;' .. luarocks_path .. '/share/lua/5.1/?/init.lua'
        package.cpath = package.cpath .. ';' .. luarocks_path .. '/lib/lua/5.1/?.so'
    end
end

setup_luarocks_paths()
-- require("gmork.lazy")
require("gmork.options")
require("gmork.keymaps")
require("gmork.plugins")
require("gmork.autocommands")
require("gmork.colorscheme")
require("gmork.cmp")
require("gmork.telescope")
require("gmork.gitsigns")
require("gmork.treesitter")
require("gmork.autopairs")
require("gmork.comment")
require("gmork.nvim-tree")
require("gmork.bufferline")
require("gmork.lualine")
require("gmork.toggleterm")
require("gmork.project")
require("gmork.impatient")
require("gmork.illuminate")
require("gmork.indentline")
require("gmork.alpha")
require("gmork.lsp")
require("gmork.dap")
require('jollama').setup({
    model = "llama3.2",
    api_url = "http://localhost:11434/api/generate"
})
