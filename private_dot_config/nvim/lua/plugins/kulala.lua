return {
	"mistweaverco/kulala.nvim",
	keys = { "<leader>Rs", "<leader>Ra", "<leader>Ro" },
	ft = { "http", "rest" },
	opts = {
		global_keymaps = false,
		contenttypes = {
			["application/json"] = {
				ft = "json",
				formatter = { "jq", "." },
			},
			["application/xml"] = {
				ft = "xml",
				formatter = { "prettier", "--parser", "xml" },
			},
			["text/html"] = {
				ft = "html",
				formatter = { "prettier", "--parser", "html" },
			},
		},
		ui = {
			display_mode = "float",
		},
	},
}
