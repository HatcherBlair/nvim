local add_on_event = require("vim-pack").add_on_event

add_on_event("BufWritePre", {
	{
		src = "stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			notify_no_fotmatter = false,
			formatters_by_ft = {
				c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
				json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				lua = { "stylua" },
				markdown = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				["_"] = { "trim_whitespace", "trim_newlines" },
			},
			format_on_save = function()
				if vim.g.minifiles_active then
					return nil
				end

				if not vim.g.autoformat then
					return nil
				end

				return {}
			end,
			formatters = {
				prettier = { require_cwd = true },
			},
		},
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.g.autoformat = true
