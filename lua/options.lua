local o         = vim.opt

o.mouse         = ""        -- disable the mouse
o.secure        = true
o.errorbells    = false      -- disable error bells (no beep/flash)
o.termguicolors = true       -- enable 24bit colors

o.updatetime    = 250        -- decrease update time
o.fileformat    = 'unix'     -- <nl> for EOL
o.switchbuf     = 'useopen'
o.encoding      = 'utf-8'
o.fileencoding  = 'utf-8'
o.backspace     = { 'eol', 'start', 'indent' }
o.matchpairs    = { '(:)', '{:}', '[:]', '<:>' }

if tonumber(vim.fn.system("grep -c 002B36 /home/shalzz/.config/alacritty/alacritty.toml")) > 0 then
  o.background = 'dark'
else
  o.background = 'light'
end

-- DO NOT NEED ANY OF THIS, CRUTCH THAT POULLUTES REGISTERS
-- vim clipboard copies to system clipboard
-- unnamed     = use the * register (ctrl-c paste in our term)
-- unnamedplus = use the + register (ctrl-v paste in our term)
-- o.clipboard         = 'unnamedplus'

o.scrolloff             = 3 -- min number of lines to keep between cursor and screen edge
o.sidescrolloff         = 5 -- min number of cols to keep between cursor and screen edge
o.textwidth             = 78 -- max inserted text width for paste operations
o.linespace             = 0 -- font spacing
o.ruler                 = true -- show line,col at the cursor pos
o.number                = true -- show absolute line no. at the cursor pos
o.relativenumber        = true -- otherwise, show relative numbers in the ruler
o.cursorline            = true -- Show a line where the current cursor is
o.signcolumn            = 'yes' -- Show sign column as first column
vim.g.colorcolumn       = 81 -- global var, mark column 81
o.colorcolumn           = tostring(vim.g.colorcolumn)
o.wrap                  = true -- wrap long lines
o.breakindent           = true -- start wrapped lines indented
o.linebreak             = true -- do not break words on line wrap

-- show menu even for one item do not auto select/insert
o.completeopt           = { 'noinsert', 'menuone', 'noselect' }
o.wildmenu              = true
o.wildmode              = 'longest:full,full'
o.wildoptions           = 'pum' -- Show completion items using the pop-up-menu (pum)
o.pumblend              = 15 -- completion menu transparency

o.joinspaces            = true -- insert spaces after '.?!' when joining lines
o.autoindent            = true -- copy indent from current line on newline
o.smartindent           = true -- add <tab> depending on syntax (C/C++)
o.startofline           = false -- keep cursor column on navigation

o.tabstop               = 4 -- Tab indentation levels every two columns
o.softtabstop           = 4 -- Tab indentation when mixing tabs & spaces
o.shiftwidth            = 4 -- Indent/outdent by two columns
o.shiftround            = true -- Always indent/outdent to nearest tabstop
o.expandtab             = true -- Convert all tabs that are typed into spaces
o.smarttab              = true -- Use shiftwidths at left margin, tabstops everywhere else

-- c: auto-wrap comments using textwidth
-- r: auto-insert the current comment leader after hitting <Enter>
-- o: auto-insert the current comment leader after hitting 'o' or 'O'
-- q: allow formatting comments with 'gq'
-- n: recognize numbered lists
-- 1: don't break a line after a one-letter word
-- j: remove comment leader when it makes sense
-- this gets overwritten by ftplugins (:verb set fo)
-- we use autocmd to remove 'o' in '/lua/autocmd.lua'
-- borrowed from tjdevries
o.formatoptions         = o.formatoptions
    - 'a'                       -- Auto formatting is BAD.
    - 't'                       -- Don't auto format my code. I got linters for that.
    + 'c'                       -- In general, I like it when comments respect textwidth
    + 'q'                       -- Allow formatting comments w/ gq
    - 'o'                       -- O and o, don't continue comments
    + 'r'                       -- But do continue when pressing enter.
    + 'n'                       -- Indent past the formatlistpat, not underneath it.
    + 'j'                       -- Auto-remove comments if possible.
    - '2'                       -- I'm not in gradeschool anymore

o.splitbelow            = true  -- ':new' ':split' below current
o.splitright            = true  -- ':vnew' ':vsplit' right of current

o.foldenable            = true  -- enable folding
o.foldlevelstart        = 10    -- open most folds by default
o.foldnestmax           = 10    -- 10 nested fold max
o.foldmethod            = 'indent' -- fold based on indent level
o.undofile              = true  --Save undo history
o.undodir               = vim.fn.getenv('HOME') .. '/.vimdid'
o.autochdir             = false -- do not change dir when opening a file

o.magic                 = true  --  use 'magic' chars in search patterns
o.hlsearch              = true  -- highlight all text matching current search pattern
o.incsearch             = true  -- show search matches as you type
o.ignorecase            = true  -- ignore case on search
o.smartcase             = true  -- case sensitive when search includes uppercase
o.showmatch             = true  -- highlight matching [{()}]
o.inccommand            = 'nosplit' -- show search and replace in real time
o.autoread              = true  -- reread a file if it's changed outside of vim
o.wrapscan              = true  -- begin search from top of the file when nothing is found

o.backup                = false -- no backup file
o.writebackup           = false -- do not backup file before write
o.swapfile              = false -- no swap file
o.compatible            = false -- disable vi compatiblity
o.spell                 = true  -- enable spellcheck
o.spelllang             = 'en'
o.laststatus            = 3     -- global statusline
o.conceallevel          = 2     -- Enable conceal by default (used mainly for markdown)

vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.solarized_italics = 0

-- Disable providers we do not care a about
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_perl_provider   = 0
vim.g.loaded_node_provider   = 0

-- Disable some in built plugins completely
local disabled_built_ins     = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'fzf',
  -- 'matchit',
  --'matchparen',
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.g.markdown_fenced_languages = {
  'vim',
  'lua',
  'cpp',
  'sql',
  'python',
  'bash=sh',
  'console=sh',
  'javascript',
  'typescript',
  'js=javascript',
  'ts=typescript',
  'yaml',
  'json',
}

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Debug Mode
vim.g.debug_load_plugins = 1

-- vim: ts=2 sts=2 sw=2 et
