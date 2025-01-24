vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

require("utils.settings-manager").load_settings()

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

require("cores.g")
require("cores.o")
require("cores.opt")

require("lazy").setup({
	spec = {
		{ import = "themes" },
		{ import = "plugins" },
		{ import = "configs" },
	},
	install = { colorscheme = { "habamaz" } },
	checker = { enable = true },
})

require("customs.plugins.init")
require("cores.keymaps")
require("cores.others")
