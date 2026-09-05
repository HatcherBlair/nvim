-- Install with
-- Windows: Visual Studio Installer
-- mac: brew install llvm (think you can also use xcode?)
-- Arch: pacman -S clang

---@type vim.lsp.Config
return {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--fallback-style=none",
		"--function-arg-placeholders=false",
	},
	filetypes = { "c", "cpp" },
	root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", ".git" },
}
