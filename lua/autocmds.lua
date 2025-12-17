-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("hatch/yank_highlight", { clear = true }),
	desc = "Hightlight on Yank",
	callback = function()
		vim.hl.on_yank({ higroup = "Visual" })
	end,
})
