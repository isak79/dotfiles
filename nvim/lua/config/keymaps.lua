-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", ":TypstPreview<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>lua require('mini.files').open()<CR>", { silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<Leader>fh",
  ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
  { noremap = true, silent = true }
)
-- vim.keymap.set(
--   "n",
--   "<leader>fh",
--   ":lua require('telescope.builtin').live_grep({ additional_args = function() return { '--hidden' } end })<cr>",
--   { silent = true, desc = "Find in Files" }
-- )
