-- General
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { silent = true })
vim.keymap.set('n', '<leader>w', ':write<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { silent = true })
vim.keymap.set('n', '<Esc>', ':nohl<CR>', { silent = true })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { silent = true })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>', { silent = true })
vim.keymap.set('v', '<C-j>', ":<C-u>silent! '<,'>m '>+1<CR>gv", { silent = true })
vim.keymap.set('v', '<C-k>', ":<C-u>silent! '<,'>m '<-2<CR>gv", { silent = true })
vim.keymap.set('n', ';', "q:", { silent = true })
vim.keymap.set('n', 'ø', "}", { silent = true })
vim.keymap.set('n', 'Ø', "{", { silent = true })
vim.keymap.set('n', 'R', ":restart<CR>", { silent = true })

-- Explore
vim.keymap.set('n', '<leader> ', ":FzfLua files<CR>", { silent = true })
vim.keymap.set('n', '<leader>/', ":FzfLua live_grep<CR>", { silent = true })
vim.keymap.set('v', '<leader>/', ":FzfLua grep_visual<CR>", { silent = true })
vim.keymap.set('n', '<leader>,', ":FzfLua buffers<CR>", { silent = true })
vim.keymap.set('n', '<leader>f', ":FzfLua lsp_document_symbols<CR>", { silent = true })
-- vim.keymap.set('n', '<leader>h', ":Pick help<CR>", { silent = true })
vim.keymap.set('n', '<leader>e', ":Oil<CR>", { silent = true })

-- Quickfix
vim.keymap.set('n', 'å', ":cnext<CR>", { silent = true })
vim.keymap.set('n', 'Å', ":cprev<CR>", { silent = true })
vim.keymap.set('n', '<leader>å', ":cexpr([])<CR>", { silent = true })
vim.keymap.set('n', '<leader>t', function ()
	local ft = vim.bo.filetype
	if ft == "qf" then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { silent = true })



--Flash
vim.keymap.set({ "n", "x", "o" }, 's', function() require("flash").jump() end)
vim.keymap.set({ "n", "x", "o" }, 'S', function() require("flash").treesitter() end)
vim.keymap.set( "o", 'r', function() require("flash").remote() end)
vim.keymap.set("c", '<C-s>', function() require("flash").toggle() end)



-- Git
vim.keymap.set('n', '<leader>gg', ":LazyGit<CR>", { silent = true })
vim.keymap.set('n', '<leader>gl', ":LazyGitLog<CR>", { silent = true })
vim.keymap.set('n', '<leader>gb', ":Gitsigns blame<CR>", { silent = true })
vim.keymap.set('n', '<leader>gs', ":Gitsigns stage_hunk<CR>", { silent = true })
vim.keymap.set('n', '<leader>gr', ":Gitsigns reset_hunk<CR>", { silent = true })
vim.keymap.set('n', '<leader>gd', ":DiffviewOpen<CR>", { silent = true })
vim.keymap.set('n', 'æ', ":Gitsigns next_hunk<CR>", { silent = true })
vim.keymap.set('n', 'Æ', ":Gitsigns prev_hunk<CR>", { silent = true })
vim.keymap.set('n', '<leader>gh', function() vim.cmd('DiffviewFileHistory %') end, { silent = true })


vim.api.nvim_create_autocmd('FileType', {
	pattern = "gitsigns-blame",
	callback = function()
		vim.keymap.set('n', 'q', ':q<CR>', { silent = true, buffer = true })
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
vim.keymap.set("n", "gd", ":FzfLua lsp_definitions<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { silent = true })

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
