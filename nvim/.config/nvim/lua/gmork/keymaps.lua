-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Window navigation handled by vim-tmux-navigator (see lazy-plugins.lua)
-- This allows seamless Ctrl+hjkl navigation between nvim and tmux panes

-- Vertical Move
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- Nx
keymap("n", "<leader>na", ":Telescope nx actions<CR>")
keymap("n", "<leader>nr", ":Telescope nx run_many<CR>")
keymap("n", "<leader>nf", ":Telescope nx affected<CR>")
keymap("n", "<leader>ng", ":Telescope nx generators<CR>")
keymap("n", "<leader>nw", ":Telescope nx workspace_generators<CR>")
keymap("n", "<leader>ne", ":Telescope nx external_generators<CR>")

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Custom Telescope searches
keymap("n", "<leader>fm", "<cmd>lua TelescopeCustom.find_mdx_files()<cr>", opts)
keymap("n", "<leader>fc", "<cmd>lua TelescopeCustom.find_components()<cr>", opts)
keymap("n", "<leader>fC", "<cmd>lua TelescopeCustom.find_config_files()<cr>", opts)
keymap("n", "<leader>ft", "<cmd>lua TelescopeCustom.find_tests()<cr>", opts)
-- Note: <leader>fT now uses todo-comments.nvim via TodoTelescope (see lazy-plugins.lua)

-- Plugin management (Lazy)
keymap("n", "<leader>pi", "<cmd>Lazy install<cr>", opts)
keymap("n", "<leader>ps", "<cmd>Lazy sync<cr>", opts)
keymap("n", "<leader>pu", "<cmd>Lazy update<cr>", opts)
keymap("n", "<leader>pc", "<cmd>Lazy clean<cr>", opts)

-- Session management
keymap("n", "<leader>ss", "<cmd>SessionSave<cr>", opts)
keymap("n", "<leader>sr", "<cmd>SessionRestore<cr>", opts)
keymap("n", "<leader>sl", "<cmd>SessionSearch<cr>", opts)
keymap("n", "<leader>sd", "<cmd>SessionDelete<cr>", opts)

-- Related files navigation
keymap("n", "<leader>gt", "<cmd>OpenTest<cr>", opts)
keymap("n", "<leader>gs", "<cmd>OpenStory<cr>", opts)

-- MDX Preview (global keymaps)
keymap("n", "<leader>md", "<cmd>lua MdxPreview.setup_mdx_split()<cr>", opts)

-- Git Worktree
keymap("n", "<leader>gw", "<cmd>WorktreeList<cr>", opts)
keymap("n", "<leader>gW", "<cmd>WorktreeCreate<cr>", opts)
keymap("n", "<leader>gB", "<cmd>WorktreeFromBranch<cr>", opts)

-- Deno
keymap("n", "<leader>dc", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>dR", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
keymap("n", "<leader>df", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
