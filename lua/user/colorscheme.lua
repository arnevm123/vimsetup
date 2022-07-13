vim.cmd [[
try
  colorscheme seoulbones 
  set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
