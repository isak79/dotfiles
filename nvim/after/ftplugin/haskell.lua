vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.keymap.set('n', '<C-p><C-p>', function()
	local cwd = vim.fn.shellescape(vim.fn.getcwd())
	os.execute('tmux new-window -c ' .. cwd .. ' "cabal repl"')
end, { silent = true, buffer = true })


vim.keymap.set('n', '<C-p><C-l>', function()
	vim.cmd("lsp enable hls")
end, { silent = true, buffer = true })
