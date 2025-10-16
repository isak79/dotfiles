vim.lsp.enable({ "lua_ls", "tinymist", "ts_ls", "rust-analyzer" })
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
	filetypes = { 'rs' },
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = false,
			}
		}
	}
})
