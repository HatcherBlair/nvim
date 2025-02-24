local M = {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true})()
	end,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {"c", "cpp", "javascript", "typescript", "asm", "lua", "vim", "vimdoc", "markdown", "java", "regex"},
			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
                additional_vim_regex_highlighting = false,
			}
		})
	end,
}

return { M }
