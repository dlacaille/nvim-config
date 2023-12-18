-- Set up formatters
require('conform').setup {
    formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { { 'prettierd', 'prettier' } },
        tsx = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        javascript = { { 'prettierd', 'prettier' } },
        vue = { { 'prettierd', 'prettier' } },
        yaml = { { 'prettierd', 'prettier' } },
        -- have other formatters configured.
        -- ['_'] = { 'trim_whitespace' },
    },
}

-- Automatically format on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(args)
        require('mini.trailspace').trim()
        require('mini.trailspace').trim_last_lines()
        require('conform').format { bufnr = args.buf }
    end,
})
