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
				"gitcommit",
				"json",
				"lua",
				"markdown",
				"vim",
				"yaml",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
}
