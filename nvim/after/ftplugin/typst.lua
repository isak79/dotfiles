local set = vim.opt_local

set.wrap = true

vim.keymap.set('n', '<leader>P', ":TypstPreview<CR>", { silent = true })
