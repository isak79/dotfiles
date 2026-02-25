-- General
vim.keymap.set('n', '<leader>w', ':write<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { silent = true })
vim.keymap.set('n', '<Esc>', ':nohl<CR>', { silent = true })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { silent = true })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>', { silent = true })
vim.keymap.set('v', '<C-j>', ":<C-u>silent! '<,'>m '>+1<CR>gv", { silent = true })
vim.keymap.set('v', '<C-k>', ":<C-u>silent! '<,'>m '<-2<CR>gv", { silent = true })
vim.keymap.set('n', 'ø', "}", { silent = true })
vim.keymap.set('n', 'Ø', "{", { silent = true })
vim.keymap.set('n', '<leader>R', ":restart<CR>", { silent = true })
vim.keymap.set('n', '<leader>u', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { silent = true })
vim.keymap.set('n', '+', '<C-w>+', { silent = true })
vim.keymap.set('n', '+', '<C-w>+', { silent = true })

-- Explore
vim.keymap.set('n', '<leader>fH', function()
	Snacks.picker.highlights()
end, { silent = true })

vim.keymap.set('n', '<leader> ', function()
	Snacks.picker.smart()
end, { silent = true })
vim.keymap.set('n', '<leader>,', function()
	Snacks.picker.buffers()
end, { silent = true })
vim.keymap.set('n', '<leader>/', function()
	Snacks.picker.grep()
end, { silent = true })
vim.keymap.set('v', '<leader>/', function()
	Snacks.picker.grep_word()
end, { silent = true })
vim.keymap.set('n', '<leader>ff', function()
	Snacks.picker.lsp_symbols()
end, { silent = true })
vim.keymap.set('n', '<leader>fr', function()
	Snacks.picker.registers()
end, { silent = true })
vim.keymap.set('n', '<leader>fq', function()
	Snacks.picker.qflist()
end, { silent = true })
vim.keymap.set('n', '<leader>fd', function()
	Snacks.picker.diagnostics()
end, { silent = true })
vim.keymap.set('n', '<leader>fl', function()
	Snacks.picker.lines()
end, { silent = true })
vim.keymap.set('n', '<leader>fh', function()
	Snacks.picker.help()
end, { silent = true })
vim.keymap.set('n', '<leader>e', ":Oil<CR>", { silent = true })

-- Quickfix
vim.keymap.set('n', 'å', ":cnext<CR>", { silent = true })
vim.keymap.set('n', 'Å', ":cprev<CR>", { silent = true })
vim.keymap.set('n', '<leader>å', ":cexpr([])<CR>", { silent = true })
vim.keymap.set('n', '<leader>o', function()
	local isOpen = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			isOpen = true
		end
	end
	if isOpen then
		vim.cmd("cclose")
		else vim.cmd("copen")
	end
end)


--Flash
vim.keymap.set({ "n", "x", "o" }, 's', require("flash").jump)
vim.keymap.set({ "n", "x", "o" }, 'S', require("flash").treesitter)
vim.keymap.set("o", 'r', require("flash").remote)
vim.keymap.set("c", '<C-s>', require("flash").toggle)

-- Git
vim.keymap.set('n', '<leader>gB', function()
	Snacks.gitbrowse()
end, { silent = true })
vim.keymap.set('n', '<leader>gb', ":Gitsigns blame<CR>", { silent = true })
vim.keymap.set('n', '<leader>gs', ":Gitsigns stage_hunk<CR>", { silent = true })
vim.keymap.set('n', '<leader>gr', ":Gitsigns reset_hunk<CR>", { silent = true })
vim.keymap.set('n', 'æ', ":Gitsigns next_hunk<CR>", { silent = true })
vim.keymap.set('n', 'Æ', ":Gitsigns prev_hunk<CR>", { silent = true })


vim.api.nvim_create_autocmd('FileType', {
	pattern = "gitsigns-blame",
	callback = function()
		vim.keymap.set('n', 'q', ':q<CR>', { silent = true, buffer = true })
	end
})

-- Buffers
vim.keymap.set('n', 'H', ':bprev<CR>', { silent = true })
vim.keymap.set('n', 'L', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { silent = true })
vim.api.nvim_create_autocmd("CmdwinEnter", {
	callback = function()
		vim.keymap.set('n', 'q', ':q<CR>', { silent = true, buffer = true })
	end
})

-- Notifications
vim.keymap.set('n', '<leader>nn', ":NoiceAll<CR>", { silent = true })
vim.keymap.set('n', '<leader>nd', ":Noice dismiss<CR>", { silent = true })

-- Lsp
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { silent = true })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { silent = true })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { silent = true })

-- Toggle clipboard
SysCB = true
vim.keymap.set('n', '<leader>c', function()
	local cb = vim.opt.clipboard:get()[1]
	if cb == nil then
		vim.o.clipboard = "unnamedplus"
		SysCB = true
	else
		vim.o.clipboard = ""
		SysCB = false
	end
end)
