WIKI_DIRECTORY = vim.fn.expand("~") .. "/projects/wiki/"

return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = {
		-- only load plugin when opening obsidian vault
		"BufReadPre "
			.. WIKI_DIRECTORY
			.. "*.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "wiki",
				path = WIKI_DIRECTORY,
			},
		},
	},
}
