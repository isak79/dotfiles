vim.lsp.enable({ "lua_ls", "tinymist", "ts_ls", "rust-analyzer" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" } }
		}
	}
})
