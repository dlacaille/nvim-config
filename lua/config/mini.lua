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

local minicomment = require('mini.comment')
minicomment.setup {}

local minibracketed = require('mini.bracketed')
minibracketed.setup {}

local minitrailspace = require('mini.trailspace')
minitrailspace.setup {}

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
