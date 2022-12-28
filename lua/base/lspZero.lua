local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "angularls",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "sumneko_lua",
    "tsserver",
})

lsp.configure('sumneko_lua', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

local default_schemas = nil
local status_ok, jsonls_settings = pcall(require, "nlspsettings.jsonls")
if status_ok then
  default_schemas = jsonls_settings.get_default_schemas()
end

local schemas = {
  {
    description = "TypeScript compiler configuration file",
    fileMatch = {
      "tsconfig.json",
      "tsconfig.*.json",
    },
    url = "https://json.schemastore.org/tsconfig.json",
  },
  {
    description = "Lerna config",
    fileMatch = { "lerna.json" },
    url = "https://json.schemastore.org/lerna.json",
  },
  {
    description = "Babel configuration",
    fileMatch = {
      ".babelrc.json",
      ".babelrc",
      "babel.config.json",
    },
    url = "https://json.schemastore.org/babelrc.json",
  },
  {
    description = "ESLint config",
    fileMatch = {
      ".eslintrc.json",
      ".eslintrc",
    },
    url = "https://json.schemastore.org/eslintrc.json",
  },
  {
    description = "Bucklescript config",
    fileMatch = { "bsconfig.json" },
    url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
  },
  {
    description = "Prettier config",
    fileMatch = {
      ".prettierrc",
      ".prettierrc.json",
      "prettier.config.json",
    },
    url = "https://json.schemastore.org/prettierrc",
  },
  {
    description = "Vercel Now config",
    fileMatch = { "now.json" },
    url = "https://json.schemastore.org/now",
  },
  {
    description = "Stylelint config",
    fileMatch = {
      ".stylelintrc",
      ".stylelintrc.json",
      "stylelint.config.json",
    },
    url = "https://json.schemastore.org/stylelintrc",
  },
  {
    description = "A JSON schema for the ASP.NET LaunchSettings.json files",
    fileMatch = { "launchsettings.json" },
    url = "https://json.schemastore.org/launchsettings.json",
  },
  {
    description = "Schema for CMake Presets",
    fileMatch = {
      "CMakePresets.json",
      "CMakeUserPresets.json",
    },
    url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
  },
  {
    description = "Configuration file as an alternative for configuring your repository in the settings page.",
    fileMatch = {
      ".codeclimate.json",
    },
    url = "https://json.schemastore.org/codeclimate.json",
  },
  {
    description = "LLVM compilation database",
    fileMatch = {
      "compile_commands.json",
    },
    url = "https://json.schemastore.org/compile-commands.json",
  },
  {
    description = "Config file for Command Task Runner",
    fileMatch = {
      "commands.json",
    },
    url = "https://json.schemastore.org/commands.json",
  },
  {
    description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
    fileMatch = {
      "*.cf.json",
      "cloudformation.json",
    },
    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
  },
  {
    description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
    fileMatch = {
      "serverless.template",
      "*.sam.json",
      "sam.json",
    },
    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
  },
  {
    description = "Json schema for properties json file for a GitHub Workflow template",
    fileMatch = {
      ".github/workflow-templates/**.properties.json",
    },
    url = "https://json.schemastore.org/github-workflow-template-properties.json",
  },
  {
    description = "golangci-lint configuration file",
    fileMatch = {
      ".golangci.toml",
      ".golangci.json",
    },
    url = "https://json.schemastore.org/golangci-lint.json",
  },
  {
    description = "JSON schema for the JSON Feed format",
    fileMatch = {
      "feed.json",
    },
    url = "https://json.schemastore.org/feed.json",
    versions = {
      ["1"] = "https://json.schemastore.org/feed-1.json",
      ["1.1"] = "https://json.schemastore.org/feed.json",
    },
  },
  {
    description = "Packer template JSON configuration",
    fileMatch = {
      "packer.json",
    },
    url = "https://json.schemastore.org/packer.json",
  },
  {
    description = "NPM configuration file",
    fileMatch = {
      "package.json",
    },
    url = "https://json.schemastore.org/package.json",
  },
  {
    description = "JSON schema for Visual Studio component configuration files",
    fileMatch = {
      "*.vsconfig",
    },
    url = "https://json.schemastore.org/vsconfig.json",
  },
  {
    description = "Resume json",
    fileMatch = { "resume.json" },
    url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
  },
}

local function extend(tab1, tab2)
  for _, value in ipairs(tab2 or {}) do
    table.insert(tab1, value)
  end
  return tab1
end

local extended_schemas = extend(schemas, default_schemas)

local opts = {
  settings = {
    json = {
      schemas = extended_schemas,
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
    vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>cI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ border = "rounded" }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ border = "rounded" }) end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    float = true,
})

local present, null_ls = pcall(require, "null-ls")
if not present then
    return
end

-- local null_opts = lsp.build_options('null-ls', {
--     on_attach = function(client)
--         if client.resolved_capabilities.document_formatting then
--             vim.api.nvim_create_autocmd("BufWritePre", {
--                 desc = "Auto format before save",
--                 pattern = "<buffer>",
--                 callback = vim.lsp.buf.formatting_sync,
--             })
--         end
--     end
-- })

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    sources = {
        diagnostics.eslint_d,
        formatting.goimports,
        code_actions.eslint_d,
        formatting.prettier,
    },
})

        -- formatting.prettierd.with({ extra_args = "/Users/arnevm/Documents/moaprfrontend/moapr/node_modules/prettier/bin-prettier.js"}),
        -- formatting.prettier_d_slim.with({
        --     extra_args = {
        --         "--single-quote",
        --         "--no-bracket-spacing",
        --         "--jsx-single-quote",
        --         "--print-width 120",
        --         "--tabWidth 2",
        --     },
        -- }),
