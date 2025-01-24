local settings = require("utils.settings-manager")
local ascii_imgs = require("utils.ascii-image-utils")

vim.cmd(string.format("colorscheme %s", settings.get_setting("theme")))

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		settings:save_settings()
	end,
})

vim.api.nvim_create_user_command("SwitchMode", function(opts)
	local mode = opts.args
	assert(mode == "normal" or mode == "horny", "Invalid mode")

	ascii_imgs.reload_img_paths(mode == "horny")
	settings.update_setting("horny_mode", mode == "horny")
	settings.update_setting("alpha_header", ascii_imgs.get_current_img_idx())

	print("Switched to mode: " .. mode)
end, {
	nargs = 1,
	complete = function()
		return { "normal", "horny" }
	end,
})
