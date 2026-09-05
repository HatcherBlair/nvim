local add = require("vim-pack").add

local colors = {
	neutral_blue = "#458588",
	bright_purple = "#d3869b",
	neutral_yellow = "#d79921",
	bright_green = "#b8bb26",
	bright_aqua = "#8ec07c",
	dark_red = "#7b2c2f",
	transparent_black = "#1e1f29",
	grey = "#928374",
	neutral_purple = "#b16286",
	white = "#f6f6f5",
}

add({
	{
		src = "ellisonleao/gruvbox.nvim",
		on_setup = function()
			require("gruvbox").setup({transparent_mode=true,})
			vim.cmd.colorscheme("gruvbox")

			---@type table<string, vim.api.keyset.highlight>
			local statusline_groups = {}
			for mode, color in pairs({
				Normal = colors.neutral_blue,
				Pending = colors.bright_purple,
				Visual = colors.neutral_yellow,
				Insert = colors.bright_green,
				Command = colors.bright_aqua,
				Other = colors.dark_red,
			}) do
				statusline_groups["StatuslineMode" .. mode] = { fg = colors.transparent_black, bg = colors.white }
				statusline_groups["StatuslineModeSeparator" .. mode] =
					{ fg = colors[color], bg = colors.transparent_black }
			end
			statusline_groups = vim.tbl_extend("error", statusline_groups, {
				StatuslineItalic = { fg = colors.grey, bg = colors.transparent_black, italic = true },
				StatuslineSpinner = { fg = colors.neutral_purple, bg = colors.transparent_black, bold = true },
				StatuslineTitle = { fg = colors.bright_white, bg = colors.transparent_black, bold = true },
				StatusLine = { fg = colors.white, bg = colors.transparent_black },
				Directory = { fg = colors.neutral_blue },
			})

			for group, opts in pairs(statusline_groups) do
				vim.api.nvim_set_hl(0, group, opts)
			end
		end,
	},
})
