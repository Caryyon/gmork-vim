local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  defaults = {
    find_command = "rg" ,
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    
    -- Rounded borders for telescope
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    
    layout_config = {
      prompt_position = "top",
      preview_cutoff = 120,
      width = 0.75,
      height = 0.75,
    },
    
    sorting_strategy = "ascending",

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "normal",
    },
  },
}

-- Custom telescope functions
local M = {}

function M.find_mdx_files()
  require("telescope.builtin").find_files({
    prompt_title = "📋 MDX Files",
    find_command = {"fd", "--type", "f", "--extension", "md", "--extension", "mdx"},
    preview = {
      check_mime_type = false,
    },
  })
end

function M.find_components()
  require("telescope.builtin").find_files({
    prompt_title = "⚛️  React Components",
    find_command = {"fd", "--type", "f", "--extension", "tsx", "--extension", "jsx"},
    search_dirs = {"src/components", "components"},
  })
end

function M.find_config_files()
  require("telescope.builtin").find_files({
    prompt_title = "⚙️  Config Files",
    find_command = {"fd", "--type", "f", "-e", "json", "-e", "js", "-e", "ts", "-e", "yaml", "-e", "yml", "-e", "toml"},
    search_dirs = {".", "config", ".config"},
    hidden = true,
  })
end

function M.find_tests()
  require("telescope.builtin").find_files({
    prompt_title = "🧪 Test Files",
    find_command = {"fd", "--type", "f", "-e", "test.ts", "-e", "test.tsx", "-e", "test.js", "-e", "test.jsx", "-e", "spec.ts", "-e", "spec.tsx"},
  })
end

function M.search_todos()
  require("telescope.builtin").live_grep({
    prompt_title = "📝 TODO/FIXME Search",
    default_text = "TODO\\|FIXME\\|NOTE\\|HACK\\|WARN",
  })
end

-- Make functions available globally
_G.TelescopeCustom = M

-- Load fzf-native extension for better performance
pcall(telescope.load_extension, "fzf")
