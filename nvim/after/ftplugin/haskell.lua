vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.keymap.set('n', '<C-p><C-p>', function()
	os.execute("tmux split-window 'cabal repl; read'")
end, { silent = true, buffer = true })


vim.keymap.set('n', '<C-p><C-l>', function()
	vim.cmd("lsp enable hls")
end, { silent = true, buffer = true })
