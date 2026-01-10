-- Formatting
return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			-- Leave me alone?
			notify_on_error = false,
			notify_no_formatters = false,
			formatters_by_ft = {
				c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
				cmake = { "cmake_format" },
				cpp = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
				cs = { "csharpier" },
				lua = { "stylua" },
				-- For fts without a formatter
				["_"] = { "trim_whitespace", "trim_newlines" },
			},
			format_on_save = function()
				-- Don't format when minfiles is open because it triggers the "confirm without synchronization" message

				-- Stop if autoformatting is disabled
				if not vim.g.autoformat then
					return nil
				end

				return {}
			end,
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

			-- Start auto-formatting by default
			vim.g.autoformat = true
		end,
	},
}
