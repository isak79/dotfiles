vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>la", "<cmd>Lazy<cr>", { desc = "Lazy" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- movement
keymap.set("n", "ø", "{", { desc = "Move one paragraph up" })
keymap.set("n", "æ", "}", { desc = "Move one paragraph down" })
keymap.set("n", "mp", "<CMD>bp<CR>", { desc = "Move to the previous buffer" })
keymap.set("n", "mn", "<CMD>bn<CR>", { desc = "Move to the next buffer" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make windows equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Move one window up" })

keymap.set("n", "<leader>uu", ":source %<CR>", { desc = "update" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "+ 1 " })
keymap.set("n", "<leader>-", "<C-x>", { desc = "- 1 " })
