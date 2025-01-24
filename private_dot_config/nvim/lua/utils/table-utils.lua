local M = {}

function M.merge(t1, t2)
	assert(type(t1) == "table", "param1 is not a table")
	assert(type(t2) == "table", "param2 is not a table")

	local merged = {}

	for k, v in pairs(t1) do
		merged[k] = v
	end

	for k, v in pairs(t2) do
		merged[k] = v
	end

	return merged
end

function M.get_keys(t)
	assert(type(t) == "table", "param is not a table")

	local keys = {}

	for key, _ in pairs(t) do
		table.insert(keys, key)
	end

	return keys
end

function M.shallow_copy(t)
	local t2 = {}
	for k, v in pairs(t) do
		t2[k] = v
	end
	return t2
end

return M
