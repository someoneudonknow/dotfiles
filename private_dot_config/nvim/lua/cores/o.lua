local o = {
	foldlevel = 99,
	foldlevelstart = 99,
	foldenable = true,
}

for k, v in pairs(o) do
	vim.o[k] = v
end
