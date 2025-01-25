return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto",
			extension = { "neo-tree", "toggleterm" },
			disabled_filetypes = {
				statusline = {
					"neo-tree",
					"alpha",
					"toggleterm",
				},
				winbar = {
					"neo-tree",
					"alpha",
					"toggleterm",
				},
				tabline = {
					"alpha",
				},
			},
		},
	},
}
