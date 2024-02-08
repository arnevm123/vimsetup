return {
	settings = {
		gopls = {
			-- buildFlags = { "-tags=linux,windows" },
			-- buildFlags = { "-tags=linux" },
			-- buildFlags = { "-tags=windows,!linux" },
			completeUnimported = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
}
