vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.smartindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", ":Ex<CR>", {noremap=true, silent=true})

-- Undotree Config
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

-- Fugitive Config
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- Move highlighted lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in middle when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


