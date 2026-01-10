-- Install with
-- Scoop: scoop install lua-language-server
-- Homebrew: brew install lua-language-server

---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	--- NOTE: These will be merged with the configuration files
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
			-- Using stylua for formatting
			formay = { enable = false },
			hint = {
				enable = true,
				arrayIndex = "Disable",
			},
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
				},
			},
		},
	},
}
