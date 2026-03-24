return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			local golangci_parser = lint.linters.golangcilint.parser
			lint.linters.golangcilint.parser = function(output, bufnr, cwd)
				local diagnostics = golangci_parser(output, bufnr, cwd)
				for _, diag in ipairs(diagnostics) do
					diag.code = diag.source
					diag.source = "golangci-lint"
				end
				return diagnostics
			end
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
			lint.linters_by_ft = {
				go = { "golangcilint", "cspell" },
				lua = { "selene" },
				haskell = { "hlint" },
				python = { "ruff" },
				sh = { "shellcheck" },
				typescript = { "eslint_d" },
				-- yaml = { "yamllint" },
				gitcommit = { "commitlint" },
				NeogitCommitMessage = { "commitlint" },
				markdown = { "cspell" },
				-- ["yaml.docker-compose"] = { "dclint" },
				["yaml.ansible"] = { "ansible_lint" },
			}

			local ns = require("lint").get_namespace("cspell")
			vim.diagnostic.config({ virtual_text = false }, ns)

			local gc_format = function(diag)
				local src = diag.code and tostring(diag.code) or diag.source or ""
				return src .. ": " .. diag.message
			end
			local ns_gc = require("lint").get_namespace("golangcilint")
			vim.diagnostic.config({
				virtual_text = { source = false, format = gc_format },
				float = { source = false, format = gc_format },
			}, ns_gc)

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
					if not vim.tbl_contains(linters, lntr) then handle:finish() end
				end
				vim.defer_fn(function() fidget_linters(handlers) end, 50)
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
