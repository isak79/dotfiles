vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/nvim-mini/mini.surround.git" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-jdtls" },
})

require("snacks").setup({
	picker = {
		enabled = true,
	}
})
require("mason").setup()
require("isak.pack.catppuccin")
require("isak.pack.lsp")
require("isak.pack.surround")
require("isak.pack.treesitter")
require("isak.pack.blink")
require("isak.pack.oil")
