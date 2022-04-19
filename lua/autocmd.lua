local au = require('au')

pcall(vim.cmd, [[
" When open a file, always jump to the last cursor position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
]])

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Required due to https://github.com/neovim/neovim/issues/9422
au.group('NewlineNoAutoComments', function(g)
  g.BufEnter = { '*', "setlocal formatoptions-=o" }
end)
