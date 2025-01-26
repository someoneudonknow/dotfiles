local M = {}

function M.get_file_name_with_extension(path)
	assert(type(path) == "string", "param is not a string")

	return vim.fn.fnamemodify(path, ":t")
end

function M.parent_dir_name(path)
	assert(type(path) == "string", "param is not a string")

	return vim.fn.fnamemodify(path, ":h")
end

function M.convert_to_table_from_file(file_path)
	assert(type(file_path) == "string", "param is not a string")

	local lines = {}
	local file = io.open(file_path, "r")

	if not file then
		print("Failed to open file:", file_path)
		return nil
	end

	for line in file:lines() do
		table.insert(lines, line)
	end

	file:close()
	return lines
end

function M.get_file_name_from_path(path)
	assert(type(path) == "string", "param is not a string")

	return vim.fn.fnamemodify(path, ":t:r")
end

function M.read_file(path)
	assert(type(path) == "string", "param is not a string")
	assert(path ~= nil, "param cannot be nil")

	local file = io.open(path, "r")

	if not file then
		return "Could not open file"
	end

	local content = file:read("*all")
	file:close()

	return content or "Empty file"
end

return M
