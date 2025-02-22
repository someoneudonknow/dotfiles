return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	VeryLazy = true,
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lang = "typescript",
	},
}
