return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters.golangcilint.args = {
			"run",
			-- "--config=~/.golangci.yaml",
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
			sh = { "shellcheck" },
			python = { "ruff" },
			-- gitcommit = { "codespell" },
			-- markdown = { "vale" },
			-- htmldjango = { "curlylint" },
			-- rst = { "vale" },
			-- java = { "codespell" },
			-- yaml = { "yamllint" },
			-- dockerfile = { "hadolint" },
			-- ghaction = { "actionlint" },
		}
		local function fidget_linters(h)
			local handlers = h or {}
			local linters = lint.get_running(0)
			if #linters == 0 then
				for _, handle in pairs(handlers) do
					handle:finish()
				end
				return
			end

			-- add missing handlers to fidget
			for _, linter in ipairs(linters) do
				if not handlers[linter] then
					handlers[linter] = require("fidget.progress").handle.create({
						title = "",
						message = "",
						lsp_client = { name = linter },
					})
				end
			end

			-- tell fidget to finish linters that are done running
			for lntr, handle in pairs(handlers) do
				if not vim.tbl_contains(linters, lntr) then
					handle:finish()
				end
			end
			vim.defer_fn(function()
				fidget_linters(handlers)
			end, 50)
		end

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				lint.try_lint()
				fidget_linters({})
			end,
		})
	end,
	event = { "BufReadPre", "BufNewFile" },
}
