return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters.commitlint.args = {
				"--config",
				"/home/arne/.config/linters/commitlint.config.os",
			}
			lint.linters.commitlint.args = {
				"--config",
				require("base.utils").git_cwd() .. "pyproject.toml",
			}
			lint.linters.cspell.args = {
				"lint",
				"--no-color",
				"--no-progress",
				"--no-summary",
				"--config",
				"~/.config/linters/cspell.json",
				"--gitignore",
			}
			lint.linters.vale.args = {
				"--no-exit",
				"--output",
				"JSON",
				"--ext",
				"." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e"),
				"--config",
				"/home/arne/.config/linters/vale/vale.ini",
			}
			lint.linters_by_ft = {
				go = { "golangcilint", "cspell" },
				lua = { "selene" },
				python = { "ruff" },
				sh = { "shellcheck" },
				typescript = { "eslint_d" },
				-- yaml = { "yamllint" },
				gitcommit = { "commitlint" },
				NeogitCommitMessage = { "commitlint" },
				markdown = { "vale", "cspell" },
				["yaml.ansible"] = { "ansible_lint" },
			}

			local ns = require("lint").get_namespace("cspell")
			vim.diagnostic.config({ virtual_text = false }, ns)

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
					fidget_linters()
				end,
			})
		end,
		event = { "VeryLazy" },
	},
}
