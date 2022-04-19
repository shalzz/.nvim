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
vim.keymap.set({ 'n', 'v', 'i'}, '<C-S>', '<C-c>:update<cr>', { silent = true })
vim.keymap.set('n', '<leader>w', ':w!<cr>', { silent = true })

-- w!! to save with sudo
vim.keymap.set('c', 'w!!', "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })

-- I can type :help on my own, thanks.
vim.keymap.set({'n', 'v', 'i'}, "<F1>", "<Esc>")
vim.keymap.set({'n', 'v', 's', 'o'}, "q:", ":q")

-- Jump to start and end of line using the home row keys
vim.keymap.set({'n', 'v'}, "H", "^")
vim.keymap.set({'n', 'v'}, "L", "$")

-- <leader>v|<leader>c act as <ctrl-v>|<ctrl-c>
-- <leader>p|P paste from yank register (0)
-- <leader>y|Y yank into clipboard/OSCyank
vim.keymap.set({'n', 'v'}, '<leader>v', '"+p')
vim.keymap.set({'n', 'v'}, '<leader>V', '"+P')
vim.keymap.set({'n', 'v'}, '<leader>c', '""y<cmd>let @+=@0<CR>')
vim.keymap.set({'n', 'v'}, '<leader>C', '""Y<cmd>let @+=@0<CR>')
vim.keymap.set({'n', 'v'}, '<leader>p', '"0p')
vim.keymap.set({'n', 'v'}, '<leader>P', '"0P')
vim.keymap.set({'n', 'v'}, '<leader>y', '<cmd>let @+=@0<CR>')
vim.keymap.set({'n', 'v'}, '<leader>Y', ':OSCYank<CR>')

-- Overloads for 'd|c' that don't pollute the unnamed registers
-- In visual-select mode 'd=delete, x=cut (unchanged)'
vim.keymap.set('v', 'd',          '"x')
vim.keymap.set('n', '<leader>d',  '"_d')
vim.keymap.set('n', '<leader>D',  '"_D')

-- Map `Y` to copy to end of line
-- conistent with the behaviour of `C` and `D`
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('v', 'Y', '<Esc>y$gv')

-- keep visual selection when (de)indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move selected lines up/down in visual mode
vim.keymap.set('x', 'K', ":move '<-2<CR>gv=gv")
vim.keymap.set('x', 'J', ":move '>+1<CR>gv=gv")

-- tmux like directional window resizes
vim.keymap.set('n', '<leader><Up>',    function() require'utils'.resize(false, -5) end, { silent = true })
vim.keymap.set('n', '<leader><Down>',  function() require'utils'.resize(false,  5) end, { silent = true })
vim.keymap.set('n', '<leader><Left>',  function() require'utils'.resize(true,  -5) end, { silent = true })
vim.keymap.set('n', '<leader><Right>', function() require'utils'.resize(true,   5) end, { silent = true })
vim.keymap.set('n', '<leader>=',       '<C-w>=',                         { silent = true })

-- Tab navigation
vim.keymap.set('n', '[t',         ':tabprevious<CR>')
vim.keymap.set('n', ']t',         ':tabnext<CR>')
vim.keymap.set('n', '[T',         ':tabfirst<CR>')
vim.keymap.set('n', ']T',         ':tablast<CR>')
vim.keymap.set('n', '<Leader>tn', ':tabnew<CR>')
vim.keymap.set('n', '<Leader>tc', ':tabclose<CR>')
vim.keymap.set('n', '<Leader>to', ':tabonly<CR>')
-- Jump to first tab & close all other tabs. Helpful after running Git difftool.
vim.keymap.set('n', '<Leader>tO', ':tabfirst<CR>:tabonly<CR>')
-- tmux <c-meta>z like
vim.keymap.set('n', '<Leader>tz',  "<cmd>lua require'utils'.tabZ()<CR>")

-- Navigate buffers
vim.keymap.set('n', '[w', ':bprevious<CR>')
vim.keymap.set('n', ']w', ':bnext<CR>')
vim.keymap.set('n', '[W', ':bfirst<CR>')
vim.keymap.set('n', ']W', ':blast<CR>')
vim.keymap.set('n',  'X', ':bdelete<CR>')
