vim.cmd [[
try
  colorscheme seoulbones 
  set background=dark
  highlight ColorColumn ctermbg=0 guibg =#555555
  highlight LineNr guifg=#5eacd3
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
