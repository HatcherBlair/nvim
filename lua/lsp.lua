-- Almost entirely borrowed from MariaSolOs <3

local M = {}

-- Cmd to toggle later
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

	-- Diagnostic Navigation
	keymap("[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, "Previous diagnostic")
	keymap("]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, "Next diagnostic")

	-- Error Navigation
	keymap("[e", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
	end, "Previous error")
	keymap("]e", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
	end, "Next error")

	-- Show Diagnostic overlay
	keymap("<leader>d", function()
		vim.diagnostic.open_float()
	end, "Open Diagnostic Menu")

	-- Document colors
	vim.lsp.document_color.enable(true, bufnr)
	if client:supports_method("textDocument/documentColor") then
		keymap("grc", function()
			vim.lsp.document_color.color_presentation()
		end, "vim.lsp.document_color.color_presentation()", { "n", "x" })
	end

	-- Find references
	if client:supports_method("textDocument/references") then
		keymap("grr", "<cmd>FzfLua lsp_references<cr>", "vim.lsp.buf.references()")
	end

	-- Go to type definition
	if client:supports_method("textDocument/typeDefinition") then
		keymap("gy", "<cmd>FzfLua lsp_typedefs<cr>", "Go to type definition")
	end

	--*** Search commands ***--
	-- Configured here because some rely on LSP features
	-- [f]iles
	keymap("<leader>ff", "<cmd>FzfLua files<cr>", "[f]ind [f]iles")

	-- project [g]rep
	keymap("<leader>fg", "<cmd>FzfLua live_grep<cr>", "[f]ind [g]rep")

	-- [b]uffer grep
	keymap("<leader>fb", "<cmd>FzfLua lgrep_curbuf<cr>", "[f]ind [b]uffer grep")

	-- current [w]ord
	keymap("<leader>fw", "<cmd>FzfLua grep_cWORD<cr>", "[f]ind Current [w]ord")

	-- [s]ymbols
	if client:supports_method("textDocument/documentSymbol") then
		keymap("<leaader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", "[f]ind Document [s]ymbols")
	end

	-- buffer [d]iagnostics
	if client:supports_method("textDocument/diagnostic") then
		keymap("<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", "[f]ind Document [d]iagnostic")
	end

	-- project [D]iagnostics
	if client:supports_method("workspace/diagnostic") then
		keymap("<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", "[f]ind Workspace [D]iagnostic")
	end

	-- [q]uickfix
	keymap("<leader>fq", "<cmd>FzfLua lgrep_quickfix<cr>", "[f]ind [q]uickfix")

	-- [h]elp tags
	keymap("<leader>fh", "<cmd>FzfLua helptags<cr>", "[f]ind [h]elp tags")

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

	-- Toggle inlay hints
	if client:supports_method("textDocument/inlayHint") then
		local inlay_hints_group = vim.api.nvim_create_augroup("hatch/toggle_inlay_hints", { clear = false })

		if vim.g.inlay_hints then
			vim.defer_fn(function()
				local mode = vim.api.nvim_get_mode().mode
				vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })
			end, 500)
		end

		vim.api.nvim_create_autocmd("InsertEnter", {
			group = inlay_hints_group,
			desc = "Enable Inlay Hints",
			buffer = bufnr,
			callback = function()
				if vim.g.inlay_hints then
					vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
				end
			end,
		})

		vim.api.nvim_create_autocmd("InsertLeave", {
			group = inlay_hints_group,
			desc = "Disable Inlay Hints",
			buffer = bufnr,
			callback = function()
				if vim.g.inlay_hints then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end,
		})
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
