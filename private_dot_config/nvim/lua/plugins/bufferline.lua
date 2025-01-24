return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			mode = "buffers",
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					separator = true,
					text_align = "left",
				},
			},
			separator_style = "slant",
		},
	},
}
