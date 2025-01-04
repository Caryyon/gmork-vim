local status_ok_config, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok_config then
	return
end

configs.setup({
  ensure_installed = { "lua", "javascript", "markdown", "markdown_inline", "bash", "python", "rust" }, -- put the language you want in this array
  -- ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "" } },
})
