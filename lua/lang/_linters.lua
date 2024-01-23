-- Set up linters
require('lint').linters_by_ft = {
    markdown = { 'vale' },
    typescript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    html = { 'eslint_d' },
    javascript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    vue = { 'eslint_d' },
}

-- Automatically lint on text changed
vim.api.nvim_create_autocmd({ 'TextChanged' }, {
    callback = function()
        require('lint').try_lint()
    end,
})
