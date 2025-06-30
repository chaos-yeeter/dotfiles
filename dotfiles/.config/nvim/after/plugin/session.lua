local session_dir = vim.fn.expand("$HOME/.sessions/neovim/")
local session_autocmd_group = vim.api.nvim_create_augroup("AutoSessionLoader", { clear = true })

-- ref: https://neovim.io/doc/user/options.html#'sessionoptions'
Utils.set("sessionoptions", "buffers,curdir,folds,resize,tabpages,winsize,options")

-- manage session files
Utils.map("n", "<leader>ss", function()
	vim.g.CUSTOM_SAVE_SESSION_FLAG = false
	vim.cmd(string.format("Oil--float %s", session_dir))
end, { desc = "Open sessions directory" })

local function exists(path)
	local success, err = os.rename(path, path)
	return not err and success
end

local function should_save_session()
	return vim.g.CUSTOM_SAVE_SESSION_FLAG
end

local function create_session()
	-- do not create session when neovim is called with args e.g. rebase, commit, etc.
	if (not should_save_session()) or (next(vim.fn.argv()) ~= nil) then
		return
	end

	-- create session directory if it does not exist
	if not exists(session_dir) then
		os.execute("mkdir -p " .. session_dir)
	end

	local current_working_dirname = string.gmatch(vim.fn.getcwd(), "[%d%a-_]+$")()
	assert(current_working_dirname, string.format("Invalid current_working_dirname: '%s'", current_working_dirname))
	local session_file_path = session_dir .. current_working_dirname .. ".vim"
	vim.cmd("silent mksession! " .. session_file_path)
end

_ = Utils.set_interval(create_session, 10000)

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	pattern = { "*" },
	desc = "Create session on exit",
	nested = true,
	once = true,
	callback = create_session,
	group = session_autocmd_group,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	pattern = { "*" },
	desc = "Load session if one exists",
	nested = true,
	once = true,
	callback = function()
		-- do not load session when neovim is called with args e.g. rebase, commit, etc.
		if next(vim.fn.argv()) ~= nil then
			return
		end

		-- enable saving sessions
		vim.g.CUSTOM_SAVE_SESSION_FLAG = true

		local current_working_dirname = string.gmatch(vim.fn.getcwd(), "[%d%a-_]+$")()
		assert(current_working_dirname, string.format("Invalid current_working_dirname: '%s'", current_working_dirname))
		local session_file_path = session_dir .. current_working_dirname .. ".vim"
		if not exists(session_file_path) then
			return
		end

		vim.cmd("silent source " .. session_file_path)
	end,
	group = session_autocmd_group,
})
