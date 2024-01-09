return {
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- Multiple cursors
    {
        'smoka7/multicursors.nvim',
        event = 'VeryLazy',
        dependencies = {
            'smoka7/hydra.nvim',
        },
        opts = {
            hint_config = false,
            normal_keys = {
                ['<C-n>'] = {
                    method = function()
                        require('multicursors.normal_mode').find_next()
                    end,
                    opts = { desc = 'Find next' },
                },
            },
        },
        cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
        keys = {
            {
                mode = { 'v', 'n' },
                '<C-n>',
                '<cmd>MCstart<cr>',
                desc = 'Create a selection for selected text or word under the cursor',
            },
        },
    },
}
