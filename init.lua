-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = "plugins"

-- My options and stuff
require("settings")
require("keymaps")
require("autocmds")
require("lsp")

-- Configure plugins
require("lazy").setup(plugins, {
	ui = { border = "rounded" },
	install = {
		missing = false,
	},
	change_detection = { notify = false },
	-- Get rid of rocks
	rocks = {
		enabled = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
