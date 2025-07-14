local open_with_trouble = require("trouble.sources.telescope").open

require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<C-t>"] = open_with_trouble },
			n = { ["<C-t>"] = open_with_trouble },
		},
		wrap_results = true,
		preview = {
			ls_short = true,
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			file_ignore_patterns = SEARCH_IGNORE_PATHS,
			additional_args = function(_)
				return { "--hidden" }
			end,
		},
		live_grep = {
			file_ignore_patterns = SEARCH_IGNORE_PATHS,
			additional_args = function(_)
				return { "--hidden" }
			end,
		},
		lsp_dynamic_workspace_symbols = {
			file_ignore_patterns = SEARCH_IGNORE_PATHS,
		},
	},
})
