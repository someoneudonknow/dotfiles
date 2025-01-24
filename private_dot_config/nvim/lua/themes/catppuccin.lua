return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	otps = {
		term_colors = true,
		integrations = {
			cmp = true,
			alpha = true,
			ufo = true,
			telescope = {
				enabled = true,
			},
			treesitter = true,
			neotree = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
		},
	},
}
