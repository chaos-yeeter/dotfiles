local rg_args = {
	"--color=never",
	"--no-heading",
	"--with-filename",
	"--line-number",
	"--column",
	"--hidden",
}

-- append ignore patterns to ripgrep args
for i = 1, #SEARCH_IGNORE_PATHS do
	table.insert(rg_args, "--glob=!" .. SEARCH_IGNORE_PATHS[i])
end

return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({
			-- needed to include hidden files
			search = {
				command = "rg",
				args = rg_args,
				pattern = [[\b(KEYWORDS):]],
			},
		})
		vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Search TODOs in the project" })
	end,
}
