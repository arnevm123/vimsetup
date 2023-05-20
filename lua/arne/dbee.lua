return {
	"arnevm123/nvim-dbee",
	branch = "feature/Add_gcloud_spanner_driver",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	build = function()
		-- Install tries to automatically detect the install method.
		-- if it fails, try calling it with one of these parameters:
		--    "curl", "wget", "bitsadmin", "go"
		require("dbee").install()
	end,
	config = function()
		require("dbee").setup({
			connections = {
				{
				  name = "dbee_spanner",
				  type = "spanner",
				  url = "projects/dbee/instances/test-instance/databases/example-db",
				},
			},
		})
	end,
	keys = {
		{ "<leader>Db", ":lua require('dbee').open()<cr>", desc = "DBee open" },
		{ "<leader>Dc", ":lua require('dbee').close()<cr>", desc = "DBee close" },
		{ "<leader>Dn", ":lua require('dbee').next()<cr>", desc = "DBee next" },
		{ "<leader>Dp", ":lua require('dbee').prev()<cr>", desc = "DBee prev" },
	},
}
