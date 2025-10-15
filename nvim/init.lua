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

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>n', ':nohl<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

-- require "blink.cmp".setup({
-- 	fuzzy = { implementation = "lua" },
-- 	keymap = { preset = 'default' },
-- 	completion = { documentation = { auto_show = false } },
-- 	appearance = {
-- 		nerd_font_variant = 'mono',
-- 	},
-- })
require("fzf-lua")
require("mason").setup()
require "blink.cmp".setup({
	fuzzy = { implementation = "lua" },
})
require "mini.pick".setup()
require("oil").setup({
	default_file_explorer = true,
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"permissions",
		"icon",
	},
	float = {
		max_width = 0.7,
		max_height = 0.6,
		border = "rounded",
	},
})
vim.keymap.set('n', '<leader> ', ":FzfLua files<CR>")
vim.keymap.set('n', '<leader>/', ":FzfLua grep_visual<CR>")
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil --float<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>gg', ":LazyGit<CR>")
vim.keymap.set('n', '<leader>gl', ":LazyGitLog<CR>")

vim.lsp.enable({ "lua_ls", "tinymist", "ts_ls" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" } }
		}
	}
})
vim.cmd("colorscheme catppuccin")
vim.cmd(":hi statusline guibg=NONE")
