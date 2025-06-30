return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			wrap_results = true,
			preview = {
				ls_short = true,
			},
		},
	},
}
