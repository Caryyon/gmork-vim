local status_ok, git_worktree = pcall(require, "git-worktree")
if not status_ok then
  return
end

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

-- Setup git-worktree
git_worktree.setup({
  change_directory_command = "cd", -- default: "cd"
  update_on_change = true, -- default: true, 
  update_on_change_command = "e .", -- default: "e ."
  clearjumps_on_change = true, -- default: true,
  autopush = false, -- default: false,
})

-- Load telescope extension
telescope.load_extension("git_worktree")

-- Hooks for additional functionality
local worktree_group = vim.api.nvim_create_augroup("GitWorktree", { clear = true })

-- Hook for when switching worktrees
git_worktree.on_tree_change(function(op, metadata)
  if op == git_worktree.Operations.Switch then
    -- Refresh file tree
    vim.cmd("NvimTreeRefresh")
    
    -- Clear search and jumps
    vim.cmd("nohlsearch")
    
    -- Update statusline
    vim.cmd("redrawstatus")
    
    -- Show notification
    print("Switched to worktree: " .. metadata.path)
    
    -- Auto-restore session if available
    local session_name = metadata.path:match("([^/]+)$")
    if session_name then
      vim.defer_fn(function()
        local session_path = vim.fn.stdpath('data') .. "/sessions/" .. session_name .. ".vim"
        if vim.fn.filereadable(session_path) == 1 then
          vim.cmd("silent! source " .. session_path)
        end
      end, 100)
    end
  elseif op == git_worktree.Operations.Create then
    print("Created worktree: " .. metadata.path)
    
    -- Optionally create a new session for this worktree
    local session_name = metadata.path:match("([^/]+)$")
    if session_name then
      vim.defer_fn(function()
        vim.cmd("SessionSave " .. session_name)
      end, 1000)
    end
  elseif op == git_worktree.Operations.Delete then
    print("Deleted worktree: " .. metadata.path)
  end
end)

-- Custom commands for easier worktree management
vim.api.nvim_create_user_command("WorktreeList", function()
  require("telescope").extensions.git_worktree.git_worktrees()
end, {})

vim.api.nvim_create_user_command("WorktreeCreate", function()
  require("telescope").extensions.git_worktree.create_git_worktree()
end, {})

vim.api.nvim_create_user_command("WorktreeSwitch", function(opts)
  if opts.args and opts.args ~= "" then
    -- Switch to specific worktree by name
    git_worktree.switch_worktree(opts.args)
  else
    -- Open telescope picker
    require("telescope").extensions.git_worktree.git_worktrees()
  end
end, { nargs = "?" })

-- Helper function to create worktree from current branch
local function create_worktree_from_branch()
  local current_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
  if current_branch == "" then
    print("Not on a git branch")
    return
  end
  
  local path = vim.fn.input("Worktree path (relative to repo root): ", current_branch .. "-worktree")
  if path and path ~= "" then
    git_worktree.create_worktree(path, current_branch)
  end
end

vim.api.nvim_create_user_command("WorktreeFromBranch", create_worktree_from_branch, {})