-- Almost entirely borrowed from MariaSolOs <3

local M = {}

-- I hate these things
vim.g.inlay_hints = false

-- Set up LSP keymaps and autocommands
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	---@param lhs string
	---@param rhs string|function
	---@param opts string|vim.keymap.set.Opts
	---@param mode? string|string[]
	local function keymap(lhs, rhs, opts, mode)
		mode = mode or "n"
		---@cast opts vim.keymap.set.Opts
		opts = type(opts) == "string" and { desc = opts } or opts
		opts.buffer = bufnr
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	keymap("[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, "Previous diagnostic")
	keymap("]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, "Next diagnostic")

	keymap("[e", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
	end, "Previous error")
	keymap("]e", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
	end, "Next error")

	-- Document colors
	vim.lsp.document_color.enable(true, bufnr)
	if client:supports_method("textDocument/documentColor") then
		keymap("grc", function()
			vim.lsp.document_color.color_presentation()
		end, "vim.lsp.document_color.color_presentation()", { "n", "x" })
	end

	-- Find references
	if client:supports_method("textDocument/references") then
		keymap("grr", "<cmd>FzfLua lsp_reference<cr>", "vim.lsp.buf.references()")
	end

	-- Go to type definition
	if client:supports_method("textDocument/typeDefinition") then
		keymap("gy", "<cmd>Fzflua lsp_typedef<cr>", "Go to type definition")
	end

	-- Search [f]ile [s]ymbols
	if client:supports_method("textDocument/documentSymbol") then
		keymap("<leader>fs", "<cmd>Fzflua lsp_document_symbols<cr>", "Document symbols")
	end

	-- Goto and Peek definition
	if client:supports_method("textDocument/definition") then
		keymap("gd", function()
			require("fzf-lua").lsp_definitions({ jump1 = true })
		end, "[g]o to [d]efinition")
		keymap("gD", function()
			require("fzf-lua").lsp_definitions({ jump1 = false })
		end, "[g]Peek [D]efinition")
	end

	-- Toggle signature help
	if client:supports_method("textDocument/signatureHelp") then
		keymap("<C-k>", function()
			-- Close the completion menu first(if open)
			if require("blink.cmp.completion.windows.menu").win:is_open() then
				require("blink.cmp").hide()
			end

			vim.lsp.buf.signature_help()
		end, "Signature help", "i")
	end

	-- Highlights references when holding in a location
	if client:supports_method("textDocument/documentHighlight") then
		local under_cursor_highlights_group = vim.api.nvim_create_augroup("hatch/cursor_highlights", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
			group = under_cursor_highlights_group,
			desc = "Highlight references under cursor",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
			group = under_cursor_highlights_group,
			desc = "Clear highlight references",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
	return hover({
		max_hight = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
	})
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
	return signature_help({
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
	})
end

-- Update mappings when registering dynamic capabilities
local register_capability = vim.lsp.handlers["client/registerCapability"]
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if not client then
		return
	end

	on_attach(client, vim.api.nvim_get_current_buf())

	return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Configure LSP keymaps",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- Maria says might be needed?
		if not client then
			return
		end

		on_attach(client, args.buf)
	end,
})

-- Set up LSP servers
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		-- Extend NVIM capabilities with the completion ones
		vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })

		local servers = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
			:map(function(file)
				return vim.fn.fnamemodify(file, ":t:r")
			end)
			:totable()
		vim.lsp.enable(servers)
	end,
})

-- HACK: Override buf_request to ignore notifications from LSP servers that don't implement a method
local buf_request = vim.lsp.buf_request
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf_request = function(bufnr, method, params, handler)
	return buf_request(bufnr, method, params, handler, function() end)
end

return M
