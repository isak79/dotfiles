vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 2
vim.o.swapfile = false
vim.o.shiftwidth = 2
vim.o.winborder = "rounded"
vim.g.mapleader = " "
vim.o.smartindent = true
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.laststatus = 3

vim.api.nvim_set_hl(0, 'LspInlayHint', {
	fg = '#808080', -- Gray text
	bg = 'NONE',   -- Remove background
	italic = true, -- Make it italic (optional)
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
	callback = function()
		vim.keymap.set('n', 'q', ':q<CR>', { silent = true, buffer = true })
	end
})

vim.api.nvim_create_autocmd("filetype", {
	group = vim.api.nvim_create_augroup("no auto comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end
})

vim.api.nvim_create_autocmd("Filetype", {
	pattern = "help",
	command = "wincmd L",
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
	group = "active_cursorline",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})


vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("LspReferenceHightlight", { clear = true }),
	callback = function()
		if vim.fn.mode() ~= "i" then
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supportsHighlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supportsHighlight = true
					break
				end
			end
			if supportsHighlight then
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end
		end
	end
})


vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local bufname = vim.fn.bufname('%')
		if string.find(bufname, "diffview") then
			vim.keymap.set('n', 'q', ':DiffviewClose<CR>', { silent = true, buffer = true })
		end
	end
})
