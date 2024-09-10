-- Install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'       -- Package manager
  use 'numToStr/Comment.nvim'        -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  use 'norcalli/nvim-colorizer.lua'  -- Color code highlighting
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'ishan9299/nvim-solarized-lua' -- Solarized Color Theme
  use 'nvim-lualine/lualine.nvim'    -- Fancier statusline
  use 'edkolev/tmuxline.vim'         -- Vim tmux statusline integration
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp'      -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'       -- Snippets plugin
  use 'andersevenrud/cmp-tmux' -- Tmux as completion source
  use 'mfussenegger/nvim-lint' -- Lints support with LSP
  -- key bindings cheatsheet
  use { 'folke/which-key.nvim',
    config = "require('which_key')",
    event = "VeryLazy",
    keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  }
  use 'tpope/vim-sleuth' -- Auto set file indents/tabs length, respects editorconfig
  use 'mickael-menu/zk-nvim'
  use 'tpope/vim-repeat'
  use 'ggandor/leap.nvim'
  use 'supermaven-inc/supermaven-nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

--- Plugins ---

--Set statusbar
vim.g.tmuxline_theme = 'vim_powerline'
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'powerline',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'tabs' }
  }
}

-- Enable Comment.nvim
require('Comment').setup()
require 'colorizer'.setup()

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<c-x>"] = "delete_buffer",
      },
      n = {
        ["<c-x>"] = "delete_buffer",
      }
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
    }
  }
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

--Add leader shortcuts
vim.keymap.set('n', '<leader><space>', function() require('telescope.builtin').buffers() end)
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').current_buffer_fuzzy_find() end)
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end)
vim.keymap.set('n', '<leader>ft', function() require('telescope.builtin').tags() end)
vim.keymap.set('n', '<leader>fd', function() require('telescope.builtin').grep_string() end)
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<leader>fo', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>fl', function() require('telescope.builtin').oldfiles() end)
vim.keymap.set('n', '<leader>f?', function() require('telescope.builtin').builtin() end)

vim.keymap.set('n', '<leader>fzz', "<Cmd>ZkNotes { sort = { 'modified' }, excludeHrefs = { 'journal/daily' } }<CR>")
vim.keymap.set('n', '<leader>fzj', "<Cmd>ZkNotes { sort = { 'modified' }, hrefs = { 'journal/daily' } }<CR>")
vim.keymap.set('n', '<leader>fzo', "<Cmd>ZkOrphans { excludeHrefs = { 'journal/daily' } }<CR>")
vim.keymap.set('n', '<leader>fzb', "<Cmd>ZkBacklinks<CR>")
vim.keymap.set('n', '<leader>fzl', "<Cmd>ZkLinks<CR>")
vim.keymap.set('n', '<leader>fzm', "<Cmd>'<,'>ZkMatch<CR>")
vim.keymap.set('n', '<leader>fzt', "<Cmd>ZkTags<CR>")

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "go",
    "javascript",
    "typescript",
    "json",
    "jsonc",
    "jsdoc",
    "lua",
    "python",
    "rust",
    "html",
    "css",
    "toml",
    "markdown",
    "markdown_inline",
    "solidity"
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},
  modules = {},
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = { "markdown" }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = 'gnn',
      -- node_incremental = 'grn',
      -- scope_incremental = 'grc',
      -- node_decremental = 'grm',
      init_selection = '<Tab>',
      scope_incremental = '<CR>',
      node_incremental = '<Tab>',
      node_decremental = '<S-Tab>',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  vim.api.nvim_create_user_command("Format", ':lua vim.lsp.buf.format()', {})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'ts_ls', 'yamlls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Setup ltex
lspconfig.ltex.setup {
  filetypes = { 'latex', 'tex', 'bib' },
  settings = {
    ltex = {
      enabled = { 'latex', 'tex', 'bib' },
      language = 'en',
      diagnosticSeverity = 'information',
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = 'en',
      },
      trace = { server = 'verbose' },
      dictionary = { ["en"] = { ":~/.config/nvim/spell/en.utf-8.add" } },
      -- disabledRules = { ['en-GB'] = { GB_SPELLING_RULE } },
      disabledRules = { ['en'] = { "EN_QUOTES" } },
      hiddenFalsePositives = {},
    },
  },
}

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'tmux' },
    -- { name = "supermaven" },
  },
}

-- supermaven setup
require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<Tab>",
    clear_suggestion = "<C-]>",
    accept_word = "<C-j>",
  },
  ignore_filetypes = { cpp = true, eml = true , markdown = true },
})

require('lint').linters_by_ft = {
  typescript      = { 'eslint' },
  typescriptreact = { 'eslint' },
  javascript      = { 'eslint' },
  jsx             = { 'eslint' },
  c               = { 'clangtidy', 'cppcheck' },
  cpp             = { 'clangtidy', 'cppcheck' },
  markdown        = { 'vale' }
}

require('leap').set_default_keymaps()

require('zk-setup')
