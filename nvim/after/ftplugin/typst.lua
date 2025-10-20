local set = vim.opt_local

set.wrap = true

vim.keymap.set('n', '<C-p>', ":TypstPreview<CR>", { silent = true, buffer = true })
