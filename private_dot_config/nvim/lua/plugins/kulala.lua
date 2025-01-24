return {
	"mistweaverco/kulala.nvim",
	opts = {
		display_mode = "float",
		debug = true,
		contenttypes = {
			["application/json"] = {
				ft = "json",
				formatter = { "prettier", "." },
				-- pathresolver = require("kulala.parser.jsonpath").parse,
			},
			["application/xml"] = {
				ft = "xml",
				formatter = { "lemminx", "--format", "-" },
				-- pathresolver = { "lemminx", "--xpath", "{{path}}", "-" },
			},
			["text/html"] = {
				ft = "html",
				formatter = { "prettier", "--format", "--html", "-" },
				-- pathresolver = {},
			},
		},
	},
}
