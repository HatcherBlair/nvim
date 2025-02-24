return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = {'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc = "Fuzy find"})
        vim.keymap.set("n", "<leader>gf", builtin.git_files, {desc = "Git files"})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "Grep"})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {desc = "Find Buffers"})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {desc = "Help me"})
    end,
}
