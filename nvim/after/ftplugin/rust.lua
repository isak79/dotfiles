vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.keymap.set('n', '<leader>P', ":echo 'hei'<CR>", { silent = true })
	end
})
