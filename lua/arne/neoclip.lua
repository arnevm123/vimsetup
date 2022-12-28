require('neoclip').setup({
    enable_persistent_history = true,
    continuous_sync = true,
    default_register_macros = 'a',
    enable_macro_history = true,
    keys = {
        telescope = {
            i = {
                select = '<cr>',
                paste = '<c-i>',
                paste_behind = '<c-o>',
                replay = '<c-q>',  -- replay a macro
                delete = '<c-d>',  -- delete an entry
                custom = {},
            },
            n = {
                select = '<cr>',
                paste = 'p',
                paste_behind = 'P',
                replay = 'q',
                delete = 'd',
                custom = {},
            },
        },
    },
})
