local opts = {
	expandtab = true,
	tabstop = 2,
	showtabline = 1,
	number = true,
	softtabstop = 2,
	shiftwidth = 2,
	relativenumber = true,
	clipboard = "unnamedplus",
	timeoutlen = 1000,
	guifont = "monospace:h17",
	mouse = "a",
	smartcase = true,
	splitbelow = true,
	splitright = true,
	smartindent = true,
	signcolumn = "yes",
	scrolloff = 8,
	sidescrolloff = 8,
	termguicolors = true,
	completeopt = { "menuone", "noselect" },
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end
