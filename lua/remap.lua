vim.keymap.set('i', 'jj', '<esc>', { desc = 'Esc with jj' })

-- Keep cursor centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Increment/Decrement
vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '-', '<C-X')

vim.keymap.set('n', '<leader>ew', '<cmd>:Ex<CR>', { desc = 'Open netrw with ew because its gross' })
