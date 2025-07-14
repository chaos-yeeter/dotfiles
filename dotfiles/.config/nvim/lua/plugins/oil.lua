return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
	lazy = false,
	opts = {
		use_default_keymaps = false,
		keymaps = {
			["<CR>"] = "actions.select",
			["<C-c>"] = { "actions.close", mode = "n" },
			["-"] = { "actions.parent", mode = "n" },
			["g."] = { "actions.toggle_hidden", mode = "n" },
			["`"] = { "actions.cd", mode = "n" },
		},
	},
}
