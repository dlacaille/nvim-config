-- Auto-close
vim.api.nvim_create_autocmd({ 'QuitPre' }, {
    callback = function()
        vim.cmd('NvimTreeClose')
    end,
})

-- Open file when created
local api = require('nvim-tree.api')
api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd('edit ' .. file.fname)
end)

-- Setup
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.3
require('nvim-tree').setup {
    sync_root_with_cwd = true,
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    view = {
        float = {
            enable = true,
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                return {
                    border = 'rounded',
                    relative = 'editor',
                    row = 2,
                    col = 0,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
        },
        width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
    },
    on_attach = function(bufnr)
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<BS>', api.tree.close, opts('Close'))
    end,
    renderer = {
        highlight_git = true,
        icons = {
            glyphs = {
                git = {
                    unstaged = '',
                    staged = '',
                    unmerged = '',
                    renamed = '',
                    untracked = '',
                    deleted = '',
                    ignored = '',
                },
            },
        },
    },
}
