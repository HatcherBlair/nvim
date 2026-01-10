-- Better highlighting
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"c",
				"cmake",
				"comment",
				"cpp",
				"c_sharp",
				"gitcommit",
				"json",
				"lua",
				"markdown",
				"vim",
				"yaml",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
}
