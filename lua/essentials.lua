local E = {}

E.set_quit_maps = function()
    vim.keymap.set('n', 'q', ':bd!<CR>', { buffer=true, silent=true })
    vim.keymap.set('n', '<ESC>', ':bd!<CR>', { buffer=true, silent=true })
end

--- vim.ui.input emulation in a float
---@param opts table: usual opts like in vim.ui.input()
---@param callback function: callback to invoke
-- TODO: implement as blocking, and no prompts as of now
-- TODO: prompt buf, prompt_setcallback() etc
E.ui_input = function(opts, callback)
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_open_win(buf, true, {
        relative='cursor', style='minimal', border='single',
        row=1, col=1, width=opts.width or 15, height=1
    })
    E.set_quit_maps()
    if opts.default then vim.api.nvim_put({opts.default}, "", true, true) end
    vim.cmd [[startinsert!]]

    vim.keymap.set('i', '<CR>', function()
        local content = vim.api.nvim_get_current_line()
        -- if opts.prompt then content = content:gsub(opts.prompt, '') end
        vim.cmd [[bd | stopinsert!]]
        callback(vim.trim(content))
    end, {buffer=true, silent=true})
end
--> Open a simple terminal with few opts.
---@param cmd string: command to run
---@param direction string: direction to open. ex: "h"/"v"/"t"
---@param close boolean: close_on_exit
E.open_term = function(cmd, direction, close)
    local dir_cmds = { h = "split | enew!", v = "vsplit | enew!", t = "enew!" }
    vim.cmd(dir_cmds[direction or 'h'])
    vim.fn.termopen(cmd, { on_exit = function(_) if close then vim.cmd('bd') end end })
end


--> VScode like rename function
function E.rename()
    local rename_old = vim.fn.expand('<cword>')
    E.ui_input({ width=15 }, function(input)
        if vim.lsp.buf.server_ready() == true then
            vim.lsp.buf.rename(vim.trim(input))
            vim.notify(rename_old..' -> '..input)
        else
            print("LSP Not ready yet!")
        end
    end)
end

--> A function to swap bools
function E.swap_bool()
    local c = vim.api.nvim_get_current_line()
    local subs = c:match("true") and c:gsub("true", "false") or c:gsub("false", "true")
    vim.api.nvim_set_current_line(subs)
end

---> Go to last edited place
function E.last_place()
    -- local markpos = vim.api.nvim_buf_get_mark(0, '"')
    local _, row, col, _ = unpack(vim.fn.getpos([['"]]))
    -- if markpos then
    -- local row, col = unpack(markpos)
    local last = vim.api.nvim_buf_line_count(0)
    if (row > 0 or col > 0) and (row <= last) then vim.cmd([[norm! '"]]) end
    -- end
end

--> Go to url under cursor (works on md links too)
---@param cmd string: the cli command to open browser. ex: "start","xdg-open"
function E.go_to_url(cmd)
    local url = vim.fn.expand('<cfile>', nil, nil)
    if not url:match("http") then
        url = "https://github.com/"..url
    end

    vim.notify("Going to "..url, 'info', { title="Opening browser..." })
    vim.fn.jobstart({cmd or "open", url}, {on_exit=function() end})
end

return E
