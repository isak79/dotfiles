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

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', {silent = true})
vim.keymap.set('n', '<leader>w', ':write<CR>', {silent = true})
vim.keymap.set('n', '<leader>q', ':quit<CR>', {silent = true})
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', {silent = true})
vim.keymap.set('n', 'H', ':bprev<CR>', {silent = true})
vim.keymap.set('n', 'L', ':bnext<CR>', {silent = true})

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', {silent = true})
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>', {silent = true})

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
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

-- require "blink.cmp".setup({
-- 	fuzzy = { implementation = "lua" },
-- 	keymap = { preset = 'default' },
-- 	completion = { documentation = { auto_show = false } },
-- 	appearance = {
-- 		nerd_font_variant = 'mono',
-- 	},
-- })
require("nvim-treesitter").setup()
require("notify").setup()
require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		format = {
			search_down = {
				view = "cmdline",
			},
			search_up = {
				view = "cmdline",
			},
		},
		hover = {
			silent = true,
		}
	},
})
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
vim.keymap.set('n', '<leader> ', ":FzfLua files<CR>", {silent = true})
vim.keymap.set('n', '<leader>/', ":FzfLua grep_visual<CR>", {silent = true})
vim.keymap.set('n', '<leader>,', ":FzfLua buffers<CR>", {silent = true})
vim.keymap.set('n', '<leader>f', ":Pick files<CR>", {silent = true})
vim.keymap.set('n', '<leader>h', ":Pick help<CR>", {silent = true})
vim.keymap.set('n', '<leader>e', ":Oil --float<CR>", {silent = true})
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {silent = true})
vim.keymap.set('n', '<leader>gg', ":LazyGit<CR>", {silent = true})
vim.keymap.set('n', '<leader>gl', ":LazyGitLog<CR>", {silent = true})
vim.keymap.set('n', '<leader>nn', ":Noice<CR>", {silent = true})
vim.keymap.set('n', '<leader>nd', ":Noice dismiss<CR>", {silent = true})


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
