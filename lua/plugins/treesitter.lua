-- Better highlighting
-- Uses the main branch, aka the one that is breaking everything
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
