local lsp_zero = require('lsp-zero')
lsp_zero.use('lua_ls', {
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
        },
    },
})
