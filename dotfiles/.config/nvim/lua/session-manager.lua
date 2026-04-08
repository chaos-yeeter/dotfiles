local M = {}

local AUTOCMD_GROUP = "session_manager"
local SESSION_DIRECTORY = vim.fn.expand("~/.local/state/nvim/sessions/")

function M._save_session()
	vim.cmd("mksession! " .. M._session_filepath)
end

function M.stop()
	pcall(vim.api.nvim_del_augroup_by_name, AUTOCMD_GROUP)

	pcall(M._timer.stop)
	pcall(M._timer.close)

	M._save_session()

	vim.notify(string.format("stopped session manager for '%s'", M._project))
end

function M.start()
	if next(vim.fn.argv()) ~= nil then
		vim.notify("skipped starting session manager")
		return
	end

	vim.opt.sessionoptions = "buffers,curdir,options,tabpages,winsize"

	M._project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	if vim.fn.isdirectory(SESSION_DIRECTORY) == 0 then
		vim.fn.mkdir(SESSION_DIRECTORY, "p")
		vim.notify(string.format("created session directory at '%s'", SESSION_DIRECTORY))
	end

	-- save session periodically
	M._timer = vim.uv.new_timer()
	-- schedule to avoid error caused by calling vim.cmd in fast context
	M._timer:start(10000, 10000, vim.schedule_wrap(M._save_session))

	vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
		pattern = { "*" },
		desc = "save session & cleanup session manager on exit",
		group = vim.api.nvim_create_augroup(AUTOCMD_GROUP, { clear = true }),
		callback = M.stop,
	})

	vim.keymap.set("n", "<leader>sQ", function()
		M.stop()
		os.remove(M._session_filepath)
		vim.notify(string.format("stopped session manager & deleted session for '%s'", M._project))
	end, { desc = "quit seesion manager & delete session" })

	-- load session if it exists
	M._session_filepath = SESSION_DIRECTORY .. M._project .. ".vim"
	-- NOTE: DO NOT create session & source it in the same flow, it will break <C-l> (& others)
	if vim.fn.filereadable(M._session_filepath) == 1 then
		vim.cmd("silent source " .. M._session_filepath)
	end

	vim.notify(string.format("started session manager for '%s'", M._project))
end

return M
