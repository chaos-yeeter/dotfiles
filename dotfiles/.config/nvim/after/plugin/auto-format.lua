local formatters_map = {
	lua = "stylua FILEPATH",
	python = "ruff check --no-cache --fix-only --select ALL FILEPATH && ruff format --silent FILEPATH",
	c = "clang-format -i FILEPATH",
	cpp = "clang-format -i FILEPATH",
	sql = [[sql-formatter --fix --config '{"keywordCase": "upper"}' FILEPATH]],
	typescript = "prettier --write FILEPATH",
	typescriptreact = "prettier --write FILEPATH",
	javascript = "prettier --write FILEPATH",
	javascriptreact = "prettier --write FILEPATH",
	yaml = "prettier --write FILEPATH",
	css = "prettier --write FILEPATH",
	markdown = "prettier --write FILEPATH",
}

local function is_formatting_disabled(filepath)
	return vim.g.AUTO_FORMAT_BLACKLIST[filepath] == true
end

local auto_format_group = vim.api.nvim_create_augroup("auto_format", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	pattern = "*",
	desc = "setup for auto format",
	callback = function(_)
		if vim.g.AUTO_FORMAT_BLACKLIST == nil then
			vim.g.AUTO_FORMAT_BLACKLIST = {}
		end
	end,
	group = auto_format_group,
	once = true,
})

vim.keymap.set("n", "<leader>tf", function()
	local filepath = vim.fn.expand("%:p")
	local blacklist = vim.g.AUTO_FORMAT_BLACKLIST

	if not blacklist[filepath] then
		blacklist[filepath] = true
		vim.notify(string.format("Disabled auto-format for file '%s'", filepath))
	else
		blacklist[filepath] = nil
		vim.notify(string.format("Enabled auto-format for file '%s'", filepath))
	end

	vim.g.AUTO_FORMAT_BLACKLIST = blacklist
end, { desc = "toggle auto format for current file" })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*",
	desc = "format buffer on save",
	callback = function(args)
		if is_formatting_disabled(args.match) then
			return
		end

		local filetype = vim.bo.filetype
		if formatters_map[filetype] then
			-- ignore output
			os.execute("(" .. string.gsub(formatters_map[filetype], "FILEPATH", args.match) .. ") > /dev/null 2>&1")

			-- refresh buffer after some time
			vim.schedule(function()
				os.execute("sleep 0.2")
				vim.cmd("silent! checktime " .. args.buf)
			end)
			return
		end

		-- fall back to LSP formatting
		if #vim.lsp.get_clients({ bufnr = args.buf, method = "textDocument/formatting" }) > 0 then
			vim.lsp.buf.format({ async = false, timeout_ms = 200 })
		end
	end,

	group = auto_format_group,
})
