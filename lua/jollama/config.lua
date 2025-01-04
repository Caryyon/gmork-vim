-- config.lua
local M = {}

M.settings = {
    model = "llama3.2",  -- Default Ollama model
    api_url = "http://localhost:11434/api/generate"  -- Default API endpoint
}

M.setup = function(user_config)
    M.settings = vim.tbl_deep_extend("force", M.settings, user_config or {})
end

return M
