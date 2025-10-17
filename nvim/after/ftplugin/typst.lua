local set = vim.opt_local

set.wrap = true

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.keymap.set('n', '<leader>P', ":TypstPreview<CR>", { silent = true })
	end
})
