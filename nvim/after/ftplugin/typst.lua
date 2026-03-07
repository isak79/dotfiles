local set = vim.opt_local

set.wrap = true

vim.keymap.set('n', '<C-p>', function()
  local client = vim.lsp.get_clients({ name = "tinymist", bufnr = 0 })[1]
  if client then
    client:exec_cmd({ command = "tinymist.startDefaultPreview", title = "Preview" })
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
