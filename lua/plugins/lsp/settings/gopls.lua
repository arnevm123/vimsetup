return {
	settings = {
		gopls = {
			buildFlags = { "-tags=linux,windows" },
			completeUnimported = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
}
