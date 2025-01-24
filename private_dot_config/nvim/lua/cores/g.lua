local g = {
	mapleader = " ",
	maplocalleader = "\\",
	guifont = "JetBrainsMono Nerd Font:h18",
}

for k, v in pairs(g) do
	vim.g[k] = v
end
