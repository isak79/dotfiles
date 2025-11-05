vim.lsp.enable({ "lua_ls", "tinymist", "ts_ls", "rust-analyzer", "hls", "bashls", "pylsp", "markdown_oxide" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" } }
		}
	}
})

vim.lsp.config('rust-analyzer', {

	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = true,
			}
		},
	},
	root_markers = {".git", "Cargo.toml", "Cargo.lock", ".gitignore"},
})
