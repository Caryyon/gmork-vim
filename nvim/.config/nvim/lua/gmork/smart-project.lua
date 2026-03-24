-- Smart project detection and configuration
local M = {}

-- Function to detect project type based on files
function M.detect_project_type()
  local cwd = vim.fn.getcwd()
  local project_files = {
    { "package.json", "node" },
    { "tsconfig.json", "typescript" },
    { "Cargo.toml", "rust" },
    { "go.mod", "go" },
    { "requirements.txt", "python" },
    { "Pipfile", "python" },
    { "pyproject.toml", "python" },
    { "Makefile", "c_cpp" },
    { "CMakeLists.txt", "c_cpp" },
  }
  
  local detected_types = {}
  
  for _, file_info in ipairs(project_files) do
    local file_path = cwd .. "/" .. file_info[1]
    if vim.fn.filereadable(file_path) == 1 then
      table.insert(detected_types, file_info[2])
    end
  end
  
  return detected_types
end

-- Function to read package.json and extract useful info
function M.get_package_json_info()
  local package_path = vim.fn.getcwd() .. "/package.json"
  
  if vim.fn.filereadable(package_path) == 1 then
    local file = io.open(package_path, "r")
    if file then
      local content = file:read("*all")
      file:close()
      
      local ok, package_data = pcall(vim.fn.json_decode, content)
      if ok and package_data then
        return {
          name = package_data.name,
          version = package_data.version,
          scripts = package_data.scripts or {},
          dependencies = package_data.dependencies or {},
          devDependencies = package_data.devDependencies or {},
        }
      end
    end
  end
  
  return nil
end

-- Function to configure based on project type
function M.configure_for_project()
  local project_types = M.detect_project_type()
  local package_info = M.get_package_json_info()
  
  -- Configure for Node.js projects
  if vim.tbl_contains(project_types, "node") then
    -- Set up common Node.js file patterns
    vim.opt_local.suffixesadd:append({".js", ".ts", ".jsx", ".tsx", ".json"})
    
    if package_info then
      -- Create commands for common npm scripts
      if package_info.scripts then
        for script_name, _ in pairs(package_info.scripts) do
          -- Convert invalid characters to create valid command names
          local command_name = "Npm" .. script_name
            :gsub("[^%w]", "") -- Remove all non-alphanumeric characters
            :gsub("^%l", string.upper) -- Capitalize first letter
          
          -- Only create command if the name is valid and not empty
          if command_name:match("^Npm%w+$") then
            vim.api.nvim_create_user_command(command_name, function()
              vim.cmd("TermExec cmd='yarn " .. script_name .. "'")
            end, {})
          end
        end
      end
      
      -- Detect framework and adjust accordingly
      local deps = vim.tbl_extend("force", package_info.dependencies, package_info.devDependencies)
      
      if deps["next"] then
        vim.g.project_framework = "nextjs"
        -- Next.js specific configurations
        vim.opt_local.path:append("pages,src/pages,app,src/app")
      elseif deps["react"] then
        vim.g.project_framework = "react"
        -- React specific configurations
        vim.opt_local.path:append("src,components,src/components")
      elseif deps["vue"] then
        vim.g.project_framework = "vue"
      elseif deps["svelte"] then
        vim.g.project_framework = "svelte"
      end
    end
  end
  
  -- Configure for TypeScript projects
  if vim.tbl_contains(project_types, "typescript") then
    -- TypeScript specific settings
    vim.opt_local.suffixesadd:append({".ts", ".tsx", ".d.ts"})
  end
  
  -- Configure for Rust projects
  if vim.tbl_contains(project_types, "rust") then
    vim.opt_local.suffixesadd:append({".rs"})
    vim.opt_local.path:append("src")
  end
  
  -- Configure for Python projects
  if vim.tbl_contains(project_types, "python") then
    vim.opt_local.suffixesadd:append({".py", ".pyi"})
  end
end

-- Function to create related file commands
function M.setup_related_file_commands()
  -- Command to open related test file
  vim.api.nvim_create_user_command("OpenTest", function()
    local current_file = vim.fn.expand("%:p")
    local test_patterns = {
      { "%.tsx?$", ".test.%1" },
      { "%.jsx?$", ".test.%1" },
      { "%.ts$", ".spec.ts" },
      { "%.js$", ".spec.js" },
      { "/([^/]+)%.tsx?$", "/__tests__/%1.test.%2" },
      { "/([^/]+)%.jsx?$", "/__tests__/%1.test.%2" },
    }
    
    for _, pattern in ipairs(test_patterns) do
      local test_file = current_file:gsub(pattern[1], pattern[2])
      if vim.fn.filereadable(test_file) == 1 then
        vim.cmd("edit " .. test_file)
        return
      end
    end
    
    print("No test file found for " .. vim.fn.expand("%:t"))
  end, {})
  
  -- Command to open related story file (for Storybook)
  vim.api.nvim_create_user_command("OpenStory", function()
    local current_file = vim.fn.expand("%:p")
    local story_patterns = {
      { "%.tsx$", ".stories.tsx" },
      { "%.jsx$", ".stories.jsx" },
      { "/([^/]+)%.tsx$", "/%1.stories.tsx" },
      { "/([^/]+)%.jsx$", "/%1.stories.jsx" },
    }
    
    for _, pattern in ipairs(story_patterns) do
      local story_file = current_file:gsub(pattern[1], pattern[2])
      if vim.fn.filereadable(story_file) == 1 then
        vim.cmd("edit " .. story_file)
        return
      end
    end
    
    print("No story file found for " .. vim.fn.expand("%:t"))
  end, {})
end

-- Auto-detect and configure on directory change
local function auto_configure()
  M.configure_for_project()
  M.setup_related_file_commands()
end

-- Set up autocommand to run on VimEnter and DirChanged
vim.api.nvim_create_autocmd({"VimEnter", "DirChanged"}, {
  pattern = "*",
  callback = auto_configure,
})

-- Initial setup
auto_configure()

return M