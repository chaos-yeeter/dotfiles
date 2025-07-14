return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters = {
				sql_formatter = {
					prepend_args = { "--config", '{"keywordCase": "upper"}' },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				sql = { "sql_formatter" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				markdown = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
