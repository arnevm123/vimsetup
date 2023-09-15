return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters.golangcilint.args = {
			"run",
			"--config=~/.golangci.yaml",
			"--out-format",
			"json",
			function()
				return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
			end,
		}
		lint.linters_by_ft = {
			lua = { "selene" },
			["yaml.ansible"] = { "ansible_lint" },
			go = { "golangcilint" },
			typescript = { "eslint_d" },
			-- gitcommit = { "codespell" },
			-- markdown = { "vale" },
			-- htmldjango = { "curlylint" },
			-- rst = { "vale" },
			-- java = { "codespell" },
			-- yaml = { "yamllint" },
			-- dockerfile = { "hadolint" },
			-- ghaction = { "actionlint" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
	event = { "BufReadPre", "BufNewFile" },
}
