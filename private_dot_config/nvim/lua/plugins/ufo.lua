return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			if filetype == "neo-tree" or filetype == "toggleterm" then
				return ""
			end
			return { "treesitter", "indent" }
		end,
	},
}
