return {
	settings = {
		gopls = {
			buildFlags = { "-tags=linux,windows,darwin" },
			completeUnimported = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
}
