-- Speed up startup
--require'impatient'.enable_profile()

-- The base
--require "base.plugins"
require "base.options"
require "base.lazy"
require "base.keymaps"
require "base.colorscheme"
require "base.lspZero"
require "base.telescope"
require "base.treesitter"

-- Other plugins
require "arne.whichkey"
require "arne.dadbod"
require "arne.debug"
require "arne.comment"
require "arne.lspSignature" -- stuff that tells function parameters
require "arne.harpoon"
require "arne.dial"
require "arne.illuminate"
require "arne.chatgpt"

-- make stuff pretty
require "arne.bufferline"
require "arne.lualine"

-- Git
require "arne.neogit"
require "arne.worktree"
require "arne.gitsigns"

-- Language specific
require "arne.go"
require "arne.quickSwitch"
