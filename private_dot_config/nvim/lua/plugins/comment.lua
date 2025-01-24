return {
	"numToStr/Comment.nvim",
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", "nvim-treesitter/nvim-treesitter" },
	event = "BufReadPre",
	lazy = false,
	opts = {
		pre_hook = function()
			require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
		end,
	},
}
