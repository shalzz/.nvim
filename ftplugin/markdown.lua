-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...) vim.api.nvim_buf_set_keymap(0, ...)end
  local opts = { noremap=true, silent=false }
  local notes_dir = vim.fn.getenv('ZK_NOTEBOOK_DIR')

  -- Open the link under the caret.
  map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- Preview a linked note.
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- Backlinks using pure LSP and showing the source context.
  map('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  -- map("v", "<leader>zvt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
  map("v", "<leader>zvt", string.format(":'<,'>ZkNewFromTitleSelection { dir = '%s' }<CR>", notes_dir), opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  -- map("v", "<leader>zvc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  map("v", "<leader>zvc", string.format(":'<,'>ZkNewFromContentSelection { dir = '%s', title = vim.fn.input('Title: ') }<CR>", notes_dir), opts)

  -- Open the code actions for a visual selection.
  map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)

end
