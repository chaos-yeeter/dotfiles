return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("lualine").setup({
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_c = { "diff", "diagnostics" },
				lualine_x = { { "filetype", icon_only = true, padding = 0 } },
				lualine_y = {
					{
						"branch",
						fmt = function(branch_name)
							if string.len(branch_name) > 25 then
								return string.sub(branch_name, 0, 22) .. "..."
							end
							return branch_name
						end,
					},
				},
				lualine_z = { "location" },
			},
		})
	end,
}
