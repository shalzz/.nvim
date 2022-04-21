if not pcall(require, "which-key") then
  return
end

-- If we do not wish to wait for timeoutlen
vim.api.nvim_set_keymap('n', '<leader>?', "<Esc>:WhichKey '' n<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>?', "<Esc>:WhichKey '' v<CR>", { noremap = true, silent = true })

-- https://github.com/folke/which-key.nvim#colors
vim.cmd([[highlight default link WhichKey          htmlH1]])
vim.cmd([[highlight default link WhichKeySeperator String]])
vim.cmd([[highlight default link WhichKeyGroup     Keyword]])
vim.cmd([[highlight default link WhichKeyDesc      Include]])
vim.cmd([[highlight default link WhichKeyFloat     CursorLine]])
vim.cmd([[highlight default link WhichKeyValue     Comment]])

require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20 -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = {gc = "Comments"},
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB"
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {1, 1, 1, 1} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 5 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specifiy a list manually
}

local opts = {
    mode = "n", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local keymaps = {
  ["<C-S>"]     = 'Save',
  ["<C-R>"]     = 'Redo',
  ["u"]         = 'Undo',
  ["U"]         = 'Undo line',
  ["."]         = 'Repeat last edit',
  ['c.']        = 'search and replace word under cursor',
  ["<up>"]      = 'Go up visual line',
  ["<down>"]    = 'Go down visual line',
  ["K"]         = 'LSP hover info under cursor',
  ["<leader>"]  = {
    ['?']       = 'Which key help',
    ['"']       = 'toggle IndentBlankline on/off',
    ['<Up>']    = 'horizontal split increase',
    ['<Down>']  = 'horizontal split decrease',
    ['<Left>']  = 'vertical split decrease',
    ['<Right>'] = 'vertical split increase',
    ['%']       = "change pwd to current file's parent",
    ['=']       = 'normalize split layout',
    ['c.']      = 'search and replace WORD under cursor',
    [' ']       = 'open buffers list',
    m = 'open :messages',
    M = 'clear :messages',
    r = 'open markdown p(r)eview',
    R = 'reload nvim configuration',
    O = 'newline above (no insert-mode)',
    o = 'newline below (no insert-mode)',
    S = 'paste before from secondary',
    s = 'paste after  from secondary',
    V = 'paste before from primary',
    v = 'paste after  from primary',
    P = 'paste before from yank register',
    p = 'paste after  from yank register',
    y = 'yank into clipboard (+)',
    Y = 'yank ANSI OSC52',
    q = "toggle quickfix list on/off",
    Q = "toggle location list on/off",
    k = 'peek definition  (LSP)',
    K = 'signature help   (LSP)',
    --[[ g = {
        name = '+git',
        g = 'Gedit',
        s = 'git status',
        r = 'Gread (reset)',
        w = 'Gwrite (stage)',
        a = 'git add (current file)',
        A = 'git add (all)',
        b = 'git blame',
        B = 'git branches',
        c = 'git commit',
        d = 'git diff (buffer)',
        D = 'git diff (project)',
        S = 'git stash (current file)',
        ['-'] = 'git stash (global)',
        ['+'] = 'git stash pop',
        p = 'git push',
        P = 'git pull',
        f = 'git fetch --all',
        F = 'git fetch origin',
        l = 'git log (current file)',
        L = 'git log (global)',
        e = 'Gedit HEAD~n (vertical)',
        E = 'Gedit HEAD~n (horizontal)',
    },
    h = {
        name = '+gitsigns',
        b = 'git blame',
        p = 'preview hunk',
        r = 'reset hunk',
        R = 'reset buffer',
        s = 'stage hunk',
        u = 'undo stage hunk',
    }, ]]
    t = {
        name = '+tab',
        n = 'open a new tab',
        c = 'close current tab',
        o = 'close all other tabs (:tabonly)',
        O = 'jump to first tab and close all others',
        z = 'zoom current tab (tmux-z)',
    },
    f = {
        name = '+find (fzf)',
        f = 'files',
        b = 'current buffer fuzzy find',
        h = 'help tags',
        t = 'tags (project)',
        o = 'tags (buffer)',
        -- T = 'tags (buffer)',
        d = 'grep string under cursor (project)',
        g = 'live grep (project)',
        l = 'old files',
        z = {
            name = '+zettlekasten (zk)',
            z = 'notes',
            b = 'backlines to current note',
            l = 'links in current note',
            m = 'match last visual selection',
            t = 'tags',
        }
    },
    ['z'] = {
            name = '+zettlekasten (zk)',
            n   = 'create new note',
            v = {
                name = "+visual",
                vt  = 'create new note with selection as title',
                vc  = 'create new note with selection as content',
            },
            j = {
                name = "+journal",
                y = "create an entry for yesterday",
                t = "create an entry for today"
            }
    },
  },
  ['g'] = {
        b = 'block comment (motion)',
        bc = 'block comment (line)',
        c = 'line comment (motion)',
        cc = 'line comment (line)',
        d = 'goto definition (LSP)',
        D = 'goto declaration (LSP)',
        r = 'references to quickfix (LSP)',
  },
  ['['] = {
        d = 'diagnostics prev (wrap)',
        [']'] = 'Previous class/object start',
        ['['] = 'Previous class/object end',
  },
  [']'] = {
        d = 'diagnostics next (wrap)',
        [']'] = 'Next class/object start',
        ['['] = 'Next class/object end',
  },
}

local wk = require("which-key")
wk.register(keymaps, opts)
