local set = vim.opt_local

set.wrap = true

vim.keymap.set('n', '<C-p>', function()
	local filename = vim.fn.bufname('%')
	os.execute("tmux split-window 'tinymist preview " .. filename .. "'")
end, { silent = true, buffer = true })


vim.keymap.set('n', 'j', function()
	return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true, buffer = true })


vim.keymap.set('n', 'k', function()
	return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true, buffer = true })


vim.api.nvim_create_autocmd("TextChangedI", {
	pattern = "*.typ",
	callback = function()
		vim.cmd(':w')
	end
})
