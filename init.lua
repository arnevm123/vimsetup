vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027Ptmux;\027\027]11;#%06x\007\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027Ptmux;\027\027]111;\007\027\\") end,
})

require("base.options")
require("base.lazy")
require("base.keymaps")
require("base.autocommand")
require("base.statusline")
