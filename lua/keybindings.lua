local remap = require'utils'.remap

-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
    cnoreabbrev Vs vs 
    cnoreabbrev Sp sp
]])

-- <ctrl-s> to Save
remap({ 'n', 'v', 'i'}, '<C-S>', '<C-c>:update<cr>', { silent = true })
remap({ 'n'}, '<leader>w', ':w!<cr>', { silent = true })

-- w!! to save with sudo
remap('c', 'w!!', "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })

-- I can type :help on my own, thanks.
remap({'n', 'v', 'i'}, "<F1>", "<Esc>")
remap({'n', 'v', 's', 'o'}, "q:", ":q")

-- Jump to start and end of line using the home row keys
remap({'n', 'v'}, "H", "^")
remap({'n', 'v'}, "L", "$")

-- <leader>v|<leader>c act as <ctrl-v>|<ctrl-c>
-- <leader>p|P paste from yank register (0)
-- <leader>y|Y yank into clipboard/OSCyank
remap({'n', 'v'}, '<leader>v', '"+p',   { noremap = true })
remap({'n', 'v'}, '<leader>V', '"+P',   { noremap = true })
remap({'n', 'v'}, '<leader>c', '"*p',   { noremap = true })
remap({'n', 'v'}, '<leader>C', '"*P',   { noremap = true })
remap({'n', 'v'}, '<leader>p', '"0p',   { noremap = true })
remap({'n', 'v'}, '<leader>P', '"0P',   { noremap = true })
remap({'n', 'v'}, '<leader>y', '<cmd>let @+=@0<CR>', { noremap = true })
remap({'n', 'v'}, '<leader>Y', ':OSCYank<CR>', { noremap = true })


-- Overloads for 'd|c' that don't pollute the unnamed registers
-- In visual-select mode 'd=delete, x=cut (unchanged)'
-- remap('v', 'd',          '"_d',     { noremap = true })
-- remap('n', '<leader>d',  '"_d',     { noremap = true })
-- remap('n', '<leader>D',  '"_D',     { noremap = true })
-- remap('n', '<leader>c',  '"_c',     { noremap = true })
-- remap('n', '<leader>C',  '"_C',     { noremap = true })
-- remap('v', '<leader>c',  '"_c',     { noremap = true })

-- Map `Y` to copy to end of line
-- conistent with the behaviour of `C` and `D`
remap('n', 'Y', 'y$',               { noremap = true })
remap('v', 'Y', '<Esc>y$gv',        { noremap = true })

-- keep visual selection when (de)indenting
remap('v', '<', '<gv', { noremap = true })
remap('v', '>', '>gv', { noremap = true })

-- Move selected lines up/down in visual mode
remap('x', 'K', ":move '<-2<CR>gv=gv", { noremap = true })
remap('x', 'J', ":move '>+1<CR>gv=gv", { noremap = true })

-- tmux like directional window resizes
remap('n', '<leader><Up>',    "<cmd>lua require'utils'.resize(false, -5)<CR>", { noremap = true, silent = true })
remap('n', '<leader><Down>',  "<cmd>lua require'utils'.resize(false,  5)<CR>", { noremap = true, silent = true })
remap('n', '<leader><Left>',  "<cmd>lua require'utils'.resize(true,  -5)<CR>", { noremap = true, silent = true })
remap('n', '<leader><Right>', "<cmd>lua require'utils'.resize(true,   5)<CR>", { noremap = true, silent = true })
remap('n', '<leader>=',       '<C-w>=',               { noremap = true, silent = true })

-- Tab navigation
remap('n', '[t',         ':tabprevious<CR>', { noremap = true })
remap('n', ']t',         ':tabnext<CR>',     { noremap = true })
remap('n', '[T',         ':tabfirst<CR>',    { noremap = true })
remap('n', ']T',         ':tablast<CR>',     { noremap = true })
remap('n', '<Leader>tn', ':tabnew<CR>',      { noremap = true })
remap('n', '<Leader>tc', ':tabclose<CR>',    { noremap = true })
remap('n', '<Leader>to', ':tabonly<CR>',    { noremap = true })
-- Jump to first tab & close all other tabs. Helpful after running Git difftool.
remap('n', '<Leader>tO', ':tabfirst<CR>:tabonly<CR>', { noremap = true })
-- tmux <c-meta>z like
remap('n', '<Leader>tz',  "<cmd>lua require'utils'.tabZ()<CR>", { noremap = true })

-- Navigate buffers
remap('n', '[w', ':bprevious<CR>',      { noremap = true })
remap('n', ']w', ':bnext<CR>',          { noremap = true })
remap('n', '[W', ':bfirst<CR>',         { noremap = true })
remap('n', ']W', ':blast<CR>',          { noremap = true })
remap('n',  'X', ':bdelete<CR>',          { noremap = true })
