local servers = {
	"lua_ls",
	"vtsls",
	"cssls",
	"html",
	"pyright",
	-- "bashls", -- Commented out due to installation issues
	"jsonls",
	"yamlls",
	-- "rust_analyzer", -- Managed by rustaceanvim
	"tailwindcss",
	-- "denols", -- Disabled to avoid conflicts with ts_ls
	"svelte",
	"mdx_analyzer",
	"clangd",
	"eslint",
	"graphql",
	"marksman",
	"remark_ls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local handlers = require("gmork.lsp.handlers")

-- Use LspAttach autocmd for on_attach (Neovim 0.11+ pattern)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client then
			handlers.on_attach(client, ev.buf)
		end
	end,
})

-- Configure and enable LSP servers
for _, server in pairs(servers) do
	local opts = {
		capabilities = handlers.capabilities,
	}

	local require_ok, conf_opts = pcall(require, "gmork.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	vim.lsp.config[server] = opts
	vim.lsp.enable(server)
end

