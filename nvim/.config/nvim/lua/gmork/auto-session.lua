local status_ok, auto_session = pcall(require, "auto-session")
if not status_ok then
  return
end

auto_session.setup({
  log_level = "error",
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
  auto_session_use_git_branch = true,
  
  -- Custom session lens for project switching
  session_lens = {
    -- Load session automatically when opening vim without arguments
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
  
  -- Hooks for custom behavior
  pre_save_cmds = {
    "NvimTreeClose", -- Close nvim-tree before saving session
    "SymbolsOutlineClose", -- Close symbols outline if you have it
  },
  
  post_restore_cmds = {
    "NvimTreeRefresh", -- Refresh nvim-tree after restore
  },
  
  -- Auto session root dir
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  
  -- Enable session lens for easier session management
  auto_session_enable_last_session = false,
  
  -- Bypass session save/restore if started with specific files
  bypass_session_save_file_types = {
    "gitcommit",
    "gitrebase",
  },
})