return {
    -- Better menus and things
    { 'stevearc/dressing.nvim', opts = {} },

    -- Highlights the symbol under the cursor.
    {
        'RRethy/vim-illuminate',
        config = function()
            require('illuminate').configure {}
        end,
    },

    -- Navigatable breadcrumbs for code
    {
        'Bekaboo/dropbar.nvim',
        event = 'VeryLazy',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
        },
    },

    -- Awesome color scheme
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup {
                transparent_background = true,
                integrations = {
                    barbar = true,
                    dropbar = {
                        enabled = true,
                        color_mode = true,
                    },
                    mini = {
                        enabled = true,
                        indentscope_color = 'lavender',
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
                highlights = {
                    FloatBorder = {
                        guifg = C.blue,
                    },
                },
            }
        end,
    },

    -- File navigation
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        event = 'VeryLazy',
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                },
            },
            default_component_configs = {
                git_status = {
                    symbols = {
                        -- Change type
                        added = '',
                        modified = '',
                        deleted = '',
                        renamed = '➜',
                        -- Status type
                        untracked = '★',
                        ignored = '◌',
                        unstaged = '',
                        staged = '',
                        conflict = '',
                    },
                },
            },
            -- Close automaticallyz when a file is opened
            event_handlers = {
                {
                    event = 'file_opened',
                    handler = function(file_path)
                        -- auto close
                        require('neo-tree.command').execute { action = 'close' }
                    end,
                },
            },
            enable_diagnostics = false,
            enable_opened_markers = false,
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
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
        event = 'VeryLazy',
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

    -- Tons of useful utilities for customizing your IDE
    -- See /config/mini.lua for configuration
    { 'echasnovski/mini.nvim', version = false },
}
