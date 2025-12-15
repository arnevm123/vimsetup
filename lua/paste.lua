local M = {}

local state = require("yankbank.state")

---@type snacks.picker.Config
M.yankbank = {
	name = "yankbank",

	finder = function()
		local yanks = state.get_yanks()
		local items = {}

		for i, text in ipairs(yanks) do
			local label = text:sub(1, 120)

			table.insert(items, {
				idx = i,
				text = text,
				label = label,
			})
		end

		return items
	end,
	format = "text",
	win = {
		list = {
			keys = {
				["<CR>"] = "paste",
			},
		},
	},
	formatters = { text = {} },
	confirm = "put",
}

return M
