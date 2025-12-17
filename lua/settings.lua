-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tab is 4 spaces
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true

-- Relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse mode
vim.o.mouse = "a"

-- Rounded borders for floating windows
vim.o.winborder = "rounded"

-- Sync clipboard
vim.o.clipboard = "unnamedplus"

-- Undofile
vim.o.undofile = true

-- Case insensitive search unless you start it
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show the signcolumn
vim.o.signcolumn = "yes"

-- Update time
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

-- Completion
vim.o.completeopt = "menu,menuone,noselect,noinsert"
vim.o.pumheight = 15

-- Split windows bottom right
vim.o.splitright = true
vim.o.splitbelow = true

-- Confirm before doing something dumb
vim.o.confirm = true

-- Preview substitutions live
vim.o.inccommand = "split"
