-- Install with
-- Windows: Visual Studio Installer
-- mac: brew install llvm (think you can also use xcode?)

local function switch_source_header(bufnr, client)
	local method_name = "textDocument/switchSourceHeader"
	if not client and not client:supports_method(method_name) then
		return vim.notify(
			("method %s is not supported by any active servers on the current buffer"):format(method_name)
		)
	end

	local params = vim.lsp.util.make_text_document_params(bufnr)
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end

		if not result then
			vim.notify("corresponding file cannot be determined")
		end

		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

---@class ClangdInitializeResult: lsp.InitializeResult
---@field offsetEncoding? string

---@type vim.lsp.Config
return {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--fallback-style=none",
		"--function-arg-placeholders=false",
	},
	filetypes = { "c", "cpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		".git",
	},
	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = { "utf-8", "utf-16" },
	},
	---@param init_result ClangdInitializeResult
	on_init = function(client, init_result)
		if init_result.offsetEncoding then
			client.offset_encoding = init_result.offsetEncoding
		end
	end,
	on_attach = function(client, bufnr)
		vim.keymap.set("n", "th", function()
			switch_source_header(bufnr, client)
		end, { desc = "[t]oggle [h]eader" })
	end,
}
