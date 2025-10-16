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
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
})


require("nvim-treesitter").setup()
require("fzf-lua")
require("mason").setup()

vim.cmd("colorscheme catppuccin")

-- vim.cmd(":hi statusline guibg=NONE")

require("isak.pack.lsp")
require("which-key").setup()
require("nvim-treesitter").setup()
require("notify").setup()
require "mini.pick".setup()

require("isak.pack.blink")
require("isak.pack.noice")
require("isak.pack.oil")
require("isak.pack.lualine")
