return {
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Automatically adds pairs of brackets
            {
                'windwp/nvim-autopairs',
                event = 'InsertEnter',
            },

            -- Helps set up LSP
            {
                'VonHeikemen/lsp-zero.nvim',
                branch = 'v3.x',
                lazy = true,
                config = false,
            },

            -- Show the method's signature
            'ray-x/lsp_signature.nvim',

            -- Useful status updates for LSP
            {
                'j-hui/fidget.nvim',
                opts = {
                    notification = {
                        window = {
                            winblend = 0,
                        },
                    },
                },
            },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',

            -- Support for C# assembly/decompilation loading
            'Decodetalkers/csharpls-extended-lsp.nvim',
        },
    },

    -- Formatters and linters
    'mfussenegger/nvim-lint',
    'stevearc/conform.nvim',
}
