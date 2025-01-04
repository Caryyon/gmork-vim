-- api.lua
local http = require("socket.http")
local config = require("jollama.config")
local json = require("dkjson")  -- Install this for JSON encoding

local M = {}

-- Function to send the code and prompt to Ollama API
M.send_to_ollama = function(selected_code, user_prompt)
    local body = json.encode({
        model = config.settings.model,
        prompt = user_prompt .. "return only the code without explanations or additional text." .. "\n" .. selected_code,
        stream = false
    })

    local response_body = {}
    local res, status_code, headers, status_text = http.request({
        url = config.settings.api_url,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = #body
        },
        source = ltn12.source.string(body),
        sink = ltn12.sink.table(response_body)
    })

    if status_code == 200 then
        print(table.concat(response_body))
        return table.concat(response_body)
    else
        print("Error:", status_code, status_text)
        return nil
    end
end

return M
