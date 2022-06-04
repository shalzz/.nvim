-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  use 'norcalli/nvim-colorizer.lua'  -- Color code highlighting
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'ishan9299/nvim-solarized-lua' -- Solarized Color Theme
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'edkolev/tmuxline.vim' -- Vim tmux statusline integration
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'andersevenrud/cmp-tmux' -- Tmux as completion source
  use 'mfussenegger/nvim-lint' -- Lints support with LSP
   -- key bindings cheatsheet
  use { 'folke/which-key.nvim',
      config = "require('which_key')",
      event = "VimEnter",
      silent = true
  }
  use 'tpope/vim-sleuth' -- Auto set file indents/tabs length, respects editorconfig
  use 'mickael-menu/zk-nvim'
  use 'ixru/nvim-markdown'
end)


local o = vim.opt

o.mouse             = 'a'       -- Enable mouse mode
o.secure            = true
o.errorbells        = false     -- disable error bells (no beep/flash)
o.termguicolors     = true      -- enable 24bit colors

o.updatetime        = 250       -- decrease update time
o.fileformat        = 'unix'    -- <nl> for EOL
o.switchbuf         = 'useopen'
o.encoding          = 'utf-8'
o.fileencoding      = 'utf-8'
o.backspace         = { 'eol', 'start', 'indent' }
o.matchpairs        = { '(:)', '{:}', '[:]', '<:>' }

if tonumber(vim.fn.system("grep -c *dark /home/shalzz/.config/alacritty/alacritty.yml")) > 0 then
    o.background = 'dark'
else
    o.background = 'light'
end

-- DO NOT NEED ANY OF THIS, CRUTCH THAT POULLUTES REGISTERS
-- vim clipboard copies to system clipboard
-- unnamed     = use the * register (ctrl-c paste in our term)
-- unnamedplus = use the + register (ctrl-v paste in our term)
-- o.clipboard         = 'unnamedplus'

o.scrolloff         = 3         -- min number of lines to keep between cursor and screen edge
o.sidescrolloff     = 5         -- min number of cols to keep between cursor and screen edge
o.textwidth         = 78        -- max inserted text width for paste operations
o.linespace         = 0         -- font spacing
o.ruler             = true      -- show line,col at the cursor pos
o.number            = true      -- show absolute line no. at the cursor pos
o.relativenumber    = true      -- otherwise, show relative numbers in the ruler
o.cursorline        = true      -- Show a line where the current cursor is
o.signcolumn        = 'yes'     -- Show sign column as first column
vim.g.colorcolumn   = 81        -- global var, mark column 81
o.colorcolumn       = tostring(vim.g.colorcolumn)
o.wrap              = true      -- wrap long lines
o.breakindent       = true      -- start wrapped lines indented
o.linebreak         = true      -- do not break words on line wrap

-- show menu even for one item do not auto select/insert
o.completeopt       = { 'noinsert' , 'menuone' , 'noselect' }
o.wildmenu          = true
o.wildmode          = 'longest:full,full'
o.wildoptions       = 'pum'     -- Show completion items using the pop-up-menu (pum)
o.pumblend          = 15        -- completion menu transparency

o.joinspaces        = true      -- insert spaces after '.?!' when joining lines
o.autoindent        = true      -- copy indent from current line on newline
o.smartindent       = true      -- add <tab> depending on syntax (C/C++)
o.startofline       = false     -- keep cursor column on navigation

o.tabstop           = 4         -- Tab indentation levels every two columns
o.softtabstop       = 4         -- Tab indentation when mixing tabs & spaces
o.shiftwidth        = 4         -- Indent/outdent by two columns
o.shiftround        = true      -- Always indent/outdent to nearest tabstop
o.expandtab         = true      -- Convert all tabs that are typed into spaces
o.smarttab          = true      -- Use shiftwidths at left margin, tabstops everywhere else

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
o.formatoptions = o.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  + 'q' -- Allow formatting comments w/ gq
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore

o.splitbelow        = true      -- ':new' ':split' below current
o.splitright        = true      -- ':vnew' ':vsplit' right of current

o.foldenable        = true      -- enable folding
o.foldlevelstart    = 10        -- open most folds by default
o.foldnestmax       = 10        -- 10 nested fold max
o.foldmethod        = 'indent'  -- fold based on indent level
o.undofile          = true      --Save undo history
o.undodir           = vim.fn.getenv('HOME')..'/.vimdid'
o.autochdir         = false     -- do not change dir when opening a file

o.magic             = true      --  use 'magic' chars in search patterns
o.hlsearch          = true      -- highlight all text matching current search pattern
o.incsearch         = true      -- show search matches as you type
o.ignorecase        = true      -- ignore case on search
o.smartcase         = true      -- case sensitive when search includes uppercase
o.showmatch         = true      -- highlight matching [{()}]
o.inccommand        = 'nosplit' -- show search and replace in real time
o.autoread          = true      -- reread a file if it's changed outside of vim
o.wrapscan          = true      -- begin search from top of the file when nothing is found

o.backup            = false     -- no backup file
o.writebackup       = false     -- do not backup file before write
o.swapfile          = false     -- no swap file
o.compatible        = false     -- disable vi compatiblity
o.spell             = true      -- enable spellcheck
o.spelllang         ='en'
o.laststatus        = 3         -- global statusline
o.conceallevel      = 2         -- Enable conceal by default (used mainly for markdown)

vim.g.do_filetype_lua    = 1    -- load filetypes.lua
vim.g.did_load_filetypes = 0    -- don't load filtypes.vim
vim.g.python3_host_prog  = '/usr/bin/python3'
vim.g.solarized_italics  = 0

--Set colorscheme
pcall(vim.cmd, [[colorscheme solarized]])

-- Disable providers we do not care a about
vim.g.loaded_python_provider  = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

-- Disable some in built plugins completely
local disabled_built_ins = {
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
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--- Plugins ---

--Set statusbar
vim.g.tmuxline_theme = 'vim_powerline'
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'powerline',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  }
}

-- Enable Comment.nvim
require('Comment').setup()
require'colorizer'.setup()

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

--[[
  https://github.com/nvim-treesitter/nvim-treesitter/issues/1168
  ** use lowercase 'solidity':
  ```
    ❯ nm -gD .local/share/nvim/site/pack/packer/start/nvim-treesitter/parser/Solidity.so
                       w _ITM_deregisterTMCloneTable
                       w _ITM_registerTMCloneTable
                       w __cxa_finalize@@GLIBC_2.2.5
                       w __gmon_start__
      00000000000232e0 T tree_sitter_solidity
  ```
  To install:
  ```
    ❯ mkdir ~/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/queries/solidity/
    ❯ curl -L https://raw.githubusercontent.com/JoranHonig/tree-sitter-solidity/master/queries/highlights.scm -o ~/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/queries/solidity/highlights.scm
    ❯ vi ~/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/queries/solidity/highlights.scm
  ```
  ** comment out lines 68-69
]]
if pcall(require, "nvim-treesitter.parsers") then
  require "nvim-treesitter.parsers".get_parser_configs().solidity = {
    install_info = {
      url = "https://github.com/JoranHonig/tree-sitter-solidity",
      files = {"src/parser.c"},
      requires_generate_from_grammar = true,
    },
    filetype = 'solidity'
  }
  -- install with ':TSInstallSync markdown'
  require "nvim-treesitter.parsers".get_parser_configs().markdown = {
    install_info = {
      url = "https://github.com/MDeiml/tree-sitter-markdown",
      files = { "src/parser.c", "src/scanner.cc" },
      -- makes treesitter ignore the 'lockfile.json' revision
      -- won't compile without this like as it tries the default
      -- markdown revision from 'MDeiml/tree-sitter-markdown'
      -- revision = "main",
    }
  }
end

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
  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Setup ltex
lspconfig.ltex.setup {
  filetypes = { 'latex', 'tex', 'bib', 'markdown' },
  settings = {
    ltex = {
      enabled = { 'latex', 'tex', 'bib', 'markdown' },
      language = 'en',
      diagnosticSeverity = 'information',
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = 'en',
        languageModel = '~/.languagemodels',
      },
      trace = { server = 'verbose' },
      dictionary = { ["en"] = {":~/.config/nvim/spell/en.utf-8.add"} },
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

lspconfig.sumneko_lua.setup {
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
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'tmux' },
  },
}

require('lint').linters_by_ft = {
  typescript        = {'eslint'},
  typescriptreact   = {'eslint'},
  javascript        = {'eslint'},
  jsx               = {'eslint'},
  c                 = {'clangtidy', 'cppcheck'},
  cpp               = {'clangtidy', 'cppcheck'},
  markdown          = {'vale'}
}

require('autocmd')
require('keybindings')
require('zk-setup')
-- vim: ts=2 sts=2 sw=2 et
