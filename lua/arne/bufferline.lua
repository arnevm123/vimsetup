return {
	"akinsho/bufferline.nvim",
	event = "BufReadPost",
	opts = {
		options = {
			numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
			left_trunc_marker = "<",
			right_trunc_marker = ">",
			close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
			right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
			left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
			middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
			max_name_length = 50,
			max_prefix_length = 50, -- prefix used when a buffer is de-duplicated
			tab_size = 30,
			-- diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
			-- diagnostics_update_in_insert = false,
			offsets = {},
			show_buffer_icons = false,
			show_buffer_close_icons = false,
			show_close_icon = false,
			show_tab_indicators = false,
			-- persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
			enforce_regular_tabs = false,
			always_show_bufferline = true,
			custom_filter = function(buf_number)
				if vim.fn.bufname(buf_number) ~= "" then
					return true
				end
			end,
		},
		highlights = {
			background = { fg = "#7c7c7c" },
			fill = { fg = "#7c7c7c" },
			tab = { fg = "#7c7c7c" },
			buffer = { fg = "#7c7c7c" },
			buffer_visible = { fg = "#7c7c7c" },
			buffer_selected = { fg = "#dddddd", bg = "#575757", bold = false, italic = false },
			modified_selected = { bg = "#575757" },
			duplicate_selected = { fg = "#7c7c7c", bg = "#575757" },
			duplicate = { fg = "#7c7c7c" },
			tab_selected = { bg = "#575757" },
			close_button_selected = { bg = "#575757" },
			diagnostic_selected = { bg = "#575757" },
			hint_selected = { bg = "#575757" },
			hint_diagnostic_selected = { bg = "#575757" },
			info_selected = { bg = "#575757" },
			info_diagnostic_selected = { bg = "#575757" },
			warning_selected = { bg = "#575757" },
			warning_diagnostic_selected = { bg = "#575757" },
			error_selected = { bg = "#575757" },
			error_diagnostic_selected = { bg = "#575757" },
			separator_selected = { bg = "#575757" },
			indicator_selected = { bg = "#575757" },
			pick_selected = { bg = "#575757" },
			separator_visible = { bg = "#575757" },
		},
	},
}
