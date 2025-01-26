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
					"neo-tree",
					"alpha",
				},
			},
		},
		tabline = {
			lualine_a = { "buffers" },
			lualine_b = { "branch" },
			lualine_c = { "filename" },
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "tabs" },
		},
	},
}
