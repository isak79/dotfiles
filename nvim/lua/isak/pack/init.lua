vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/nvim-mini/mini.surround.git" },
	{ src = "https://github.com/nvim-mini/mini.ai" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/stevearc/quicker.nvim" },
})


require("quicker").setup()

require("snacks").setup({
	picker = {
		enabled = true,
	}
})

require("mini.ai").setup()

require("mason").setup()

vim.cmd("colorscheme catppuccin")

require("isak.pack.lsp")
require("isak.pack.surround")
require("notify").setup()

require("isak.pack.treesitter")
require("isak.pack.blink")
require("isak.pack.noice")
require("isak.pack.oil")
require("isak.pack.lualine")
