local add_on_event = require("vim-pack").add_on_event

local solid_bar = require("icons").misc.vertical_bar
local dashed_bar = require("icons").misc.dashed_bar

add_on_event({ "BufReadPre", "BufNewFile" }, {
	{
		src = "lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = solid_bar },
				untracked = { text = solid_bar },
				change = { text = solid_bar },
				delete = { text = solid_bar },
				topdelete = { text = dashed_bar },
				changedeleted = { text = dashed_bar },
			},
			preview_config = { border = "rounded" },
			current_line_blame = true,
			gh = true,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				---@param lhs string
				---@param rhs function
				---@param desc string
				local function nmap(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = bufnr })
				end

				nmap("[g", gs.prev_hunk, "Previous Hunk")
				nmap("]g", gs.next_hunk, "Next Hunk")
				nmap("<leader>gR", gs.reset_buffer, "Reset buffer")
				nmap("<leader>gb", gs.blame_line, "Blame Line")
				nmap("<leader>gp", gs.preview_hunk, "Preview Hunk")
				nmap("<leader>gr", gs.reset_hunk, "Reset Hunk")
				nmap("<leader>gs", gs.stage_hunk, "Stage Hunk")
			end,
		},
	},
})
