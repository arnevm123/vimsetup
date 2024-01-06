-- Set default values if they do not exist
local rg_command = "rg --vimgrep"
local default_dir = "./"

local chunks = {""}
local error_flag = false
local rg_job = 0

local function alert(msg)
    vim.api.nvim_echo({{msg, "WarningMsg"}}, true, {})
end

local function show_results(data, title)
    vim.fn.setqflist({})
    vim.fn.setqflist({}, 'r', {context = 'file_search', title = title})
    vim.fn.setqflist(data, 'a', {title = title})
    vim.cmd("copen")
    chunks = {""}
end

local function remove_trailing_empty_line(lines)
    if #lines > 1 and lines[#lines] == "" then
        return vim.fn.copy(lines, 1, #lines - 1)
    end
    return lines
end

local function has_quote(item)
    return #vim.fn.matchstr(item, '^.*"$') > 0 or #vim.fn.matchstr(item, "^.*'$") > 0
end

local function not_option(item)
    return #item > 0 and item:sub(1, 1) ~= '-'
end

local function is_option(item)
    return #item > 0 and item:sub(1, 1) == '-'
end

local function rg_event(job_id, data, event)
    local msg = "Error: Pattern - " .. self.pattern .. " - not found"

    if event == "stdout" then
        chunks[#chunks] = chunks[#chunks] .. data[1]
        for i = 2, #data do
            table.insert(chunks, data[i])
        end
    elseif event == "on_stderr" then
        error_flag = true
        alert(msg)
    elseif event == "exit" then
        if error_flag then
            error_flag = false
            return
        end

        if rg_job == 0 then
            chunks = {""}
            return
        end

        rg_job = 0

        if chunks[1] == "" then
            alert(msg)
            return
        end

        alert("")
        show_results(remove_trailing_empty_line(chunks), self.cmd)
    end
end

local function run_cmd(cmd, pattern)
    if rg_job ~= 0 then
        vim.fn.jobstop(rg_job)
        rg_job = 0
        alert("Search interrupted. Please try your search again.")
        return
    end

    if vim.fn.has("nvim") and rg_run_async ~= 0 then
        alert("Searching...")
        local opts = {
            on_stdout = vim.fn["s:RgEvent"],
            on_stderr = vim.fn["s:RgEvent"],
            on_exit = vim.fn["s:RgEvent"],
            pattern = pattern,
            cmd = cmd
        }
        rg_job = vim.fn.jobstart(cmd, opts)
        return
    end

    local cmd_output = vim.fn.system(cmd)
    if cmd_output == "" then
        alert("Error: Pattern - " .. pattern .. " - not found")
        return
    end

    show_results(cmd_output, cmd)
end

local function run_rg(cmd)
    if #cmd > 0 then
        local cmd_options = rg_command .. " " .. cmd .. " " .. default_dir
        run_cmd(cmd_options, cmd)
        return
    end

    local pattern = vim.fn.input("Search for pattern: ")
    if pattern == "" then
        return
    end

    local startdir = vim.fn.input("Start searching from directory: ", "./")
    if startdir == "" then
        return
    end

    local ftype = vim.fn.input("File type (optional): ", "")
    if ftype ~= "" then
        ftype = " -t " .. ftype
    end

    local cmd = rg_command .. ftype .. " '" .. pattern .. "' " .. startdir
    run_cmd(cmd, pattern)
end
