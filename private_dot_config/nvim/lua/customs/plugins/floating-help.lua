local Popup = require("nui.popup")

local function open_floating_help(query)
	assert(query, "param cannot be empty")

	vim.cmd("silent! help " .. query)

	local help_bufnr = vim.api.nvim_get_current_buf()
	local file_type = vim.bo[help_bufnr].filetype

	if file_type ~= "help" then
		vim.notify("Sorry there're no help for " .. query, vim.log.levels.INFO)
		return nil
	end

	local lines = vim.api.nvim_buf_get_lines(help_bufnr, 0, -1, false)

	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local start_line = cursor_pos[1] - 1

	vim.cmd("bdelete " .. help_bufnr)

	local bufnr = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	vim.bo[bufnr].filetype = "help"

	local popup = Popup({
		position = "50%",
		size = 0.75,
		enter = true,
		focusable = true,
		zindex = 50,
		relative = "editor",
		border = {
			padding = { 2, 2 },
			style = "rounded",
			text = {
				top = " Help: " .. query .. " ",
				top_align = "center",
				bottom = " Press [<Esc> | q] or unfocus to close ",
				bottom_align = "right",
			},
		},
		bufnr = bufnr,
		buf_options = {
			modifiable = false,
			readonly = true,
		},
		win_options = {
			winblend = 10,
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	})

	popup:mount()

	vim.api.nvim_win_set_cursor(popup.winid, { start_line + 1, 0 })

	local function close_popup()
		popup:unmount()
	end

	popup:map("n", "q", close_popup, { noremap = true, silent = true })
	popup:map("n", "<Esc>", close_popup, { noremap = true, silent = true })

	popup:on("BufLeave", close_popup)
end

vim.api.nvim_create_user_command("H", function(opts)
	open_floating_help(opts.args)
end, {
	nargs = 1,
	complete = "help",
})
