local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local snips = require("plugins.snip.snips")

local in_fn = {
	show_condition = snips.in_function,
	condition = snips.in_function,
}

local snippets = {
	ls.s("re", {
		ls.t("return "),
		ls.i(1),
		ls.t({ "" }),
		ls.d(2, snips.make_default_return_nodes, { 1 }),
	}, snips.in_fn),

	ls.s(
		{ trig = "ifc", name = "if call", dscr = "Call a function and check the error" },
		fmt(
			[[
        {val}, {err1} := {func}({args})
        if {err2} != nil {{
          return {err3}
        }}
        {finally}
      ]],
			{
				val = ls.i(1, { "val" }),
				err1 = ls.i(2, { "err" }),
				func = ls.i(3, { "func" }),
				args = ls.i(4),
				err2 = rep(2),
				err3 = ls.d(5, snips.make_return_nodes, { 2 }),
				finally = ls.i(0),
			}
		),
		snips.in_fn
	),

	ls.s(
		{ trig = "ifce", name = "if call err inline", dscr = "Call a function and check the error inline" },
		fmt(
			[[
        if {err1} := {func}({args}); {err2} != nil {{
          return {err3}
        }}
        {finally}
      ]],
			{
				err1 = ls.i(1, { "err" }),
				func = ls.i(2, { "func" }),
				args = ls.i(3, { "args" }),
				err2 = rep(1),
				err3 = ls.d(4, snips.make_return_nodes, { 1 }),
				finally = ls.i(0),
			}
		),
		snips.in_fn
	),
	ls.s(
		{ trig = "ife", name = "If error, choose me!", dscr = "If error, return wrapped with dynamic node" },
		fmt("if {} != nil {{\n\treturn {}\n}}\n{}", {
			ls.i(1, "err"),
			ls.d(2, snips.make_return_nodes, { 1 }, { user_args = { { "a1", "a2" } } }),
			ls.i(0),
		}),
		in_fn
	),
}

ls.add_snippets("go", snippets)
