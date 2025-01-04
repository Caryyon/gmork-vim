-- Require the API module
local api = require("jollama.api")

local M = {}

-- Get the selected code from the visual selection (v-line mode)
local function get_visual_selection()
    vim.cmd('normal! gv')  -- Reselect the visual selection
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    if not start_pos or not end_pos then
        print("Error: Could not retrieve visual selection positions.")
        return nil
    end

    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    if not lines or #lines == 0 then
        print("Error: No lines selected.")
        return nil
    end

    -- Handle single-line and multi-line selections
    if #lines == 1 then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    else
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    end

    return table.concat(lines, '\n')  -- Return the selected lines as a single string
end

-- Replace visual selection with the API response
local function replace_visual_selection(response)
    if not response then
        print("Error: No valid response to replace the selection.")
        return
    end
    
    -- Reselect the previously highlighted text using 'gv'
    vim.cmd('normal! gv')

    -- Set the response in the unnamed register and paste it over the selection
    vim.fn.setreg('"', response)  -- Set response in the default unnamed register
    vim.cmd('normal! "p')  -- Paste the response
end

-- Main function to handle yank, API request, and replacing the code
M.process_selection_with_input = function()
    -- Yank the selected code
    local selected_code = get_visual_selection()

    if not selected_code then
        print("Error: Could not retrieve selected code.")
        return
    end

    -- Use Neovim's built-in input prompt to prompt the user for input
    local prompt = vim.fn.input("What would you like to do with this code? ")

    -- If the user cancels input (i.e., input is empty), return early
    if prompt == "" then
        print("No input provided, aborting.")
        return
    end

    -- Send the selected code and prompt to the API
    local response = api.send_to_ollama(selected_code, prompt)

    -- Replace the selection with the API response
    if response then
        replace_visual_selection(response)
    else
        print("Error: No response from Ollama")
    end
end

return M
