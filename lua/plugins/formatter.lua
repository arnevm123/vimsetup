return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				go = {
					function()
						return {
							exe = "gofumpt",
							stdin = true,
						}
					end,
					function()
						return {
							exe = "goimports-reviser",
							args = { "--project-name go.nexuzhealth.com" },
						}
					end,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})
	end,
	cmd = { "Format" },
	keys = { { "<leader>lf", "<CMD>Format<CR>" }, { "<leader>wf", ":FormatWrite<CR>" } },
}
