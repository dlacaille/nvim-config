-- File browser
local files = require('mini.files')
files.setup {
    mappings = {
        go_in = 'L',
        go_in_plus = '<CR>',
        go_out = '',
        go_out_plus = '<BS>',
        reset = 'H',
    },
}

local files_set_cwd = function()
    -- Works only if cursor is on the valid file system entry
    local cur_entry_path = MiniFiles.get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    vim.fn.chdir(cur_directory)
end

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        -- Keymaps for mini.files
        vim.keymap.set('n', '.', files_set_cwd, { buffer = args.data.buf_id })
        vim.keymap.set('n', '<ESC>', files.close, { buffer = args.data.buf_id })
    end,
})

-- Show the current scope of indentation with an animated line
local mis = require('mini.indentscope')
mis.setup {
    draw = {
        animation = mis.gen_animation.quadratic {
            duration = 100,
            unit = 'total',
        },
    },
    symbol = '▎',
}

-- Shows which keys are available
local miniclue = require('mini.clue')
miniclue.setup {
    triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        -- Lsp-zero mappings
        { mode = 'n', keys = 'gd', desc = 'Go to definition' },
        { mode = 'n', keys = 'gD', desc = 'Go to declaration' },
        { mode = 'n', keys = 'gi', desc = 'Go to implementation' },
        { mode = 'n', keys = 'go', desc = 'Go to type definition' },
        { mode = 'n', keys = 'gr', desc = 'Type references' },
        { mode = 'n', keys = 'gs', desc = 'Signature help' },
        { mode = 'n', keys = 'gl', desc = 'Show diagnostics' },
        -- Leader root mappings
        { mode = 'n', keys = '<leader>b', desc = 'Build' },
        { mode = 'n', keys = '<leader>g', desc = 'Git' },
        { mode = 'n', keys = '<leader>h', desc = 'Git hunk' },
        { mode = 'n', keys = '<leader>f', desc = 'Find' },
    },

    window = {
        config = { width = 80 },
        delay = 0,
    },
}

-- Allows to comment lines
local minicomment = require('mini.comment')
minicomment.setup {}

-- Go forward/backward with square brackets
local minibracketed = require('mini.bracketed')
minibracketed.setup {}

-- Highlights spaces at the end of lines
local minitrailspace = require('mini.trailspace')
minitrailspace.setup {}

-- Highlights some text patterns
local hipatterns = require('mini.hipatterns')
hipatterns.setup {
    highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
}

-- Provides simple pickers for files using rg
local minipick = require('mini.pick')
minipick.setup {
    mappings = {
        choose_marked = '<C-q>', -- Send to quickfix
        paste_system_clipboard = {
            char = '<C-v>',
            func = function()
                -- Simulate the keypresses for <C-r> (paste register), * (system register)
                vim.api.nvim_input(vim.api.nvim_replace_termcodes('<C-r>*', true, true, true))
            end,
        },
    },
}

vim.keymap.set('n', '<leader>ff', minipick.builtin.files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>gf', function()
    minipick.builtin.files { tool = 'git' }
end, { desc = 'Search git files' })
vim.keymap.set('n', '<leader>fw', minipick.builtin.grep_live, { desc = 'Find by words' })
vim.keymap.set('n', '<leader>fh', minipick.builtin.help, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fr', minipick.builtin.resume, { desc = 'Find Resume' })
vim.keymap.set('n', '<leader><space>', minipick.builtin.buffers, { desc = 'Find existing buffers' })

-- Highlights the word under cursor
local minicw = require('mini.cursorword')
minicw.setup {}

-- Notifications
local notify = require('mini.notify')
notify.setup {}
