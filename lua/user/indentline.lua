local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end
indent_blankline.setup({
    buftype_exclude = {"terminal", "nowrite", "help"},
    show_trailing_blankline_indent = false,
    show_current_context = true,
})
