local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- Try to load gmork custom theme
local gmork_ok, gmork = pcall(require, "colors.gmork")
local lualine_theme = "auto"
if gmork_ok and gmork.lualine_theme then
  lualine_theme = gmork.lualine_theme
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- LSP server status
local lsp_server = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if next(clients) == nil then
    return "No LSP"
  end

  local client_names = {}
  for _, client in pairs(clients) do
    if client.name ~= "null-ls" and client.name ~= "none-ls" then
      table.insert(client_names, client.name)
    end
  end
  
  if #client_names == 0 then
    return "No LSP"
  end
  
  return "LSP: " .. table.concat(client_names, ", ")
end

-- Project detection
local project_name = function()
  local cwd = vim.fn.getcwd()
  local project = vim.fn.fnamemodify(cwd, ":t")
  return "📁 " .. project
end

-- Git status with more info
local git_status = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  
  local added = git_info.added and git_info.added > 0 and ("+" .. git_info.added) or ""
  local modified = git_info.changed and git_info.changed > 0 and ("~" .. git_info.changed) or ""
  local removed = git_info.removed and git_info.removed > 0 and ("-" .. git_info.removed) or ""
  
  local changes = {}
  if added ~= "" then table.insert(changes, added) end
  if modified ~= "" then table.insert(changes, modified) end
  if removed ~= "" then table.insert(changes, removed) end
  
  local status = table.concat(changes, " ")
  if status ~= "" then
    return git_info.head .. " [" .. status .. "]"
  else
    return git_info.head
  end
end

-- File type with icon enhancement
local file_info = function()
  local file_type = vim.bo.filetype
  local file_enc = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  local file_format = vim.bo.fileformat
  
  if file_type == "" then
    return file_enc .. " [" .. file_format .. "]"
  end
  
  return file_type .. " | " .. file_enc .. " [" .. file_format .. "]"
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = lualine_theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { project_name },
    lualine_c = { 
      {
        'filename',
        path = 1, -- Show relative path
        shorting_target = 40,
        symbols = {
          modified = '[+]',
          readonly = '[RO]',
          unnamed = '[No Name]',
        }
      },
      diagnostics 
    },
    lualine_x = { 
      {
        git_status,
        cond = function() return vim.b.gitsigns_status_dict ~= nil end
      },
      lsp_server,
      diff, 
      spaces 
    },
    lualine_y = { file_info },
    lualine_z = { location, "progress" },
  },
}
