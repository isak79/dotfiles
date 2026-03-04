local set = vim.opt_local

set.wrap = true

vim.keymap.set('n', '<C-p>', function()
	vim.lsp.buf.execute_command({ command = "tinymist.startDefaultPreview", title = "Preview" })
end, { silent = true, buffer = true })


vim.keymap.set('n', 'j', function()
	return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true, buffer = true })


vim.keymap.set('n', 'k', function()
	return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true, buffer = true })


-- vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
-- 	pattern = "*.typ",
-- 	callback = function()
-- 		vim.cmd(':w')
-- 	end
-- })
