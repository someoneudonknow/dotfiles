return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		popup = {
			win_options = {
				winblend = 20, -- Adjust transparency
			},
		},
		cmdline_popup = {
			win_options = {
				winblend = 20, -- Reduce opacity for command-line popup
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = true,
			lsp_doc_border = true,
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = {
				stages = "static",
				timeout = 3000,
				background_colour = "#000000",
			},
		},
	},
}
