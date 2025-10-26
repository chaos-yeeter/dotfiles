---origin & size information for a window
---@class WindowBounds
---@field x integer x co-ordinate of top-left point of the window
---@field y integer y co-ordinate of top-left point of the window
---@field width integer width of the window
---@field height integer height of the window

---check if navigation from source_window to target_window is valid in given direction
---@param direction string direction of navigation
---@param source_window_bounds WindowBounds bounds for source window
---@param target_window_bounds WindowBounds bounds for target window
---@return boolean
local function is_valid_direction(direction, source_window_bounds, target_window_bounds)
	local x_displacement = target_window_bounds.x - source_window_bounds.x
	local y_displacement = target_window_bounds.y - source_window_bounds.y
	-- add 1 to account for separator between windows
	if direction == "right" then
		return x_displacement == source_window_bounds.width + 1
	elseif direction == "left" then
		return x_displacement == -(target_window_bounds.width + 1)
	elseif direction == "down" then
		return y_displacement == source_window_bounds.height + 1
	elseif direction == "up" then
		return y_displacement == -(target_window_bounds.height + 1)
	end
	error("Invalid direction:" .. direction)
end

---move focus to window in given direction
---@param direction string must be one of: up, down, left or right
local function move(direction)
	assert(
		direction == "up" or direction == "down" or direction == "left" or direction == "right",
		"Invalid direction: " .. direction
	)

	local window_ids = vim.api.nvim_tabpage_list_wins(0)
	if #window_ids < 2 then
		return
	end

	local source_window_id = vim.api.nvim_tabpage_get_win(0)
	local source_window_position = vim.api.nvim_win_get_position(source_window_id)
	-- OPTIMIZE: cache window bounds to avoid re-calculation. delete cache entry on WinClosed
	---@type WindowBounds
	local source_window_bounds = {
		x = source_window_position[2],
		y = source_window_position[1],
		width = vim.api.nvim_win_get_width(source_window_id),
		height = vim.api.nvim_win_get_height(source_window_id),
	}

	local nearest_valid_window_id = nil
	local min_distance = 1000000
	for _, target_window_id in ipairs(window_ids) do
		if target_window_id ~= source_window_id then
			local target_window_position = vim.api.nvim_win_get_position(target_window_id)
			---@type WindowBounds
			local target_window_bounds = {
				x = target_window_position[2],
				y = target_window_position[1],
				width = vim.api.nvim_win_get_width(target_window_id),
				height = vim.api.nvim_win_get_height(target_window_id),
			}
			if is_valid_direction(direction, source_window_bounds, target_window_bounds) then
				if target_window_id == vim.t.last_visited_window_id then
					nearest_valid_window_id = target_window_id
					break
				end

				local distance = math.abs(target_window_bounds.x - source_window_bounds.x)
					+ math.abs(target_window_bounds.y - source_window_bounds.y)
				if distance < min_distance then
					min_distance = distance
					nearest_valid_window_id = target_window_id
				end
			end
		end
	end
	if nearest_valid_window_id ~= nil then
		vim.api.nvim_tabpage_set_win(0, nearest_valid_window_id)
	end
end

vim.api.nvim_create_autocmd("WinLeave", {
	group = vim.api.nvim_create_augroup("window_navigation", { clear = true }),
	callback = function()
		vim.t.last_visited_window_id = vim.api.nvim_tabpage_get_win(0)
	end,
})

-- window navigation
vim.keymap.set("n", "<C-h>", function()
	move("left")
end, { desc = "go to window to the left of current window" })
vim.keymap.set("n", "<C-j>", function()
	move("down")
end, { desc = "go to window below the current window" })
vim.keymap.set("n", "<C-k>", function()
	move("up")
end, { desc = "go to window above the current window" })
vim.keymap.set("n", "<C-l>", function()
	move("right")
end, { desc = "go to window to the right of current window" })
