-- local set = vim.opt_local

vim.api.nvim_command("TSBufEnable highlight")

vim.keymap.set('n', '<leader>P', function()
	local filename = vim.fn.bufname('%')
	os.execute("tmux split-window 'ghci " .. filename .. "; read'")
end, { silent = true, buffer = true })

