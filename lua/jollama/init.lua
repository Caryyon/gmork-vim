-- init.lua: Main entry point for Jollama
local config = require("jollama.config")
local commands = require("jollama.commands")

-- Set up the plugin with user configuration
local M = {}

M.setup = function(user_config)
    config.setup(user_config)
    commands.setup()
end

return M
