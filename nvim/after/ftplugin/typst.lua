local set = vim.opt_local

set.wrap = true

vim.keymap.set('n', '<C-p>', function()
	local clients = vim.lsp.get_clients({ name = "tinymist", bufnr = 0 })
	if #clients > 0 then
		clients[1]:exec_cmd({ command = "tinymist.startDefaultPreview", title = "Preview" })
	else
		vim.notify("Tinymist LSP client not found", vim.log.levels.WARN)
	end
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
