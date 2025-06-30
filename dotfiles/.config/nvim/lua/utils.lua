Utils = {}

-- map keys
function Utils.map(mode, key, command, options)
	vim.keymap.set(mode, key, command, options)
end

-- set options
function Utils.set(option, value)
	vim.opt[option] = value
end

-- set local options
function Utils.set_local(option, value)
	vim.opt_local[option] = value
end

-- change keymap
function Utils.change_keymap(mode, new_keymap, old_keymap)
	vim.api.nvim_set_keymap(mode, new_keymap, old_keymap, {})
end

-- periodically execute callback
-- ref: https://neovim.io/doc/user/luvref.html#uv_timer_t
function Utils.set_interval(callback, interval_in_ms)
	local timer = vim.uv.new_timer()
	timer:start(interval_in_ms, interval_in_ms, function()
		vim.schedule(callback)
	end)
	return timer
end

return Utils
