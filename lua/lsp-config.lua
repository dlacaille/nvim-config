local lsp_zero = require('lsp-zero')

--  This function gets run when an LSP connects to a particular buffer.
lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps {
        buffer = bufnr,
        preserve_mappings = false,
    }
end)

-- Set up neovim lsp
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require('neodev').setup {
    -- add any options here, or leave empty to use the default settings
}

require('mason').setup {
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
}

require('mason-lspconfig').setup {
    -- This is the list of servers to install and configure using lsp-zero
    ensure_installed = { 'csharp_ls', 'tsserver', 'lua_ls', 'volar' },
    handlers = {
        lsp_zero.default_setup,
    },
}

-- Install required tools
require('mason-tool-installer').setup {
    ensure_installed = {
        'eslint_d',
        'prettierd',
        'stylua',
        'vale',
    },
}

-- Show file signature
require('lsp_signature').setup {}
