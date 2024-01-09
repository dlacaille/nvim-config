return {
    -- Better menus and things
    {
        'stevearc/dressing.nvim',
        opts = {},
    },

    -- Navigatable breadcrumbs for code
    {
        'Bekaboo/dropbar.nvim',
    },

    -- Awesome color scheme
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup {
                transparent_background = true,
                integrations = {
                    alpha = false,
                    barbar = true,
                    dropbar = {
                        enabled = true,
                        color_mode = true,
                    },
                    flash = false,
                    mason = true,
                    neogit = false,
                    ufo = false,
                    rainbow_delimiters = false,
                    mini = {
                        enabled = true,
                        indentscope_color = 'lavender',
                    },
                    telescope = {
                        enabled = false,
                    },
                    nvimtree = false,
                    neotree = true,
                },
            }
            vim.cmd.colorscheme('catppuccin')
        end,
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    },

    -- Easy terminals
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        config = function()
            local C = require('catppuccin.palettes').get_palette()
            require('toggleterm').setup {
                shell = 'pwsh -NoLogo',
                highlights = {
                    FloatBorder = {
                        guifg = C.blue,
                    },
                },
            }
        end,
    },

    -- Set feline as statusline
    {
        'freddiehaddad/feline.nvim',
        event = 'VeryLazy',
        config = function()
            local C = require('catppuccin.palettes').get_palette()
            local components = require('catppuccin.groups.integrations.feline').get()
            components.active[3][3].enabled = false
            components.active[3][4].left_sep.hl.bg = C.mantle

            require('feline').setup {
                components = components,
            }
        end,
    },

    -- Set barbar as tabline
    {
        'romgrk/barbar.nvim',
        event = 'BufAdd', -- Defer opening barbar until a buffer is added
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            sidebar_filetypes = {
                ['neo-tree'] = { event = 'BufWipeout' },
            },
            icons = {
                separator = { left = '', right = '' },
                separator_at_end = false,
                inactive = { separator = { left = '', right = '' } },
            },
        },
        version = '^1.0.0',
    },

    -- Add indentation guides even on blank lines
    {
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        opts = {
            indent = {
                char = '▎',
            },
            scope = { enabled = false },
        },
    },
}
