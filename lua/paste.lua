local M = {}

local state = require("yankbank.state")

---@type snacks.picker.Config
M.yankbank = {
	name = "yankbank",
	finder = function()
		local yanks = state.get_yanks()
		local items = {}

		for i, text in ipairs(yanks) do
			-- what you show in the list
			local label = text:gsub("\n", "↵")
			label = label:sub(1, 120) -- truncate visually

			table.insert(items, {
				idx = i,
				text = text,
				label = label,
			})
		end

		return items
	end,

	format = "text",
	preview = "none",

	layout = {
		preset = "vscode",
	},

	-- When user hits Enter
	confirm = function(item)
		if not item or not item.idx then
			return
		end

		local text = state.get_yanks()[item.idx]
		local reg_type = state.get_reg_types()[item.idx] or "v"

		-- restore yank into default register
		vim.fn.setreg('"', text, reg_type)

		-- auto-paste
		vim.api.nvim_feedkeys("p", "n", false)
	end,

	formatters = { text = {} },
}
return M
