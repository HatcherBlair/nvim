vim.loader.enable()

require("settings")
require("keymaps")
--require("commands")
require("autocmds")
require("statusline")
require("winbar")
--require 'marks'
require("lsp")

vim.cmd.packadd("nvim.undotree")
