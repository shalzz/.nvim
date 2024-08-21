if not pcall(require, "zk") then
  return
end

local zk = require("zk")
local commands = require("zk.commands")

zk.setup({
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = "telescope",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

commands.add("ZkOrphans", function(options)
  options = vim.tbl_extend("force", { orphan = true }, options or {})
  zk.edit(options, { title = "Zk Orphans" })
end)

local dir = vim.fn.getenv('ZK_NOTEBOOK_DIR')..'/journal/daily'
vim.keymap.set("n", "<leader>znn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", {silent = false})
vim.keymap.set("n", "<leader>zjy", string.format("<Cmd>ZkNew { dir = '%s', format-date = 'yesterday' }<CR>", dir), {silent = false})
vim.keymap.set("n", "<leader>zjt", string.format("<Cmd>ZkNew { dir = '%s' }<CR>", dir), {silent = false})
