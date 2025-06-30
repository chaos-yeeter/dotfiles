local telescope = require("telescope")
local builtin = require("telescope.builtin")
local open_with_trouble = require("trouble.sources.telescope").open

-- show hidden files
telescope.setup({
	defaults = {
		mappings = {
			i = { ["<c-t>"] = open_with_trouble },
			n = { ["<c-t>"] = open_with_trouble },
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		live_grep = {
			file_ignore_patterns = { ".git", "node_modules", ".venv" },
			additional_args = function(_)
				return { "--hidden" }
			end,
		},
		lsp_dynamic_workspace_symbols = {
			file_ignore_patterns = { ".cache" },
		},
	},
})

-- search
local search_trigger = "<leader>f"
Utils.map("n", string.format("%sg", search_trigger), builtin.git_files)
Utils.map("n", string.format("%sf", search_trigger), function()
	builtin.find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
end)
Utils.map("n", string.format("%sw", search_trigger), builtin.live_grep)
Utils.map("n", string.format("%sb", search_trigger), builtin.buffers)
