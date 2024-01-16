-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- https://github.com/neovim/neovim/issues/8435
-- Workaround using this command for Windows Terminal to use C-Space as an alias for C-Y
--   { "command": { "action": "sendInput", "input": "\u0019" }, "keys": "ctrl+space" }
vim.keymap.set('n', '<C-y>', vim.lsp.buf.hover)
vim.keymap.set('n', '<C-Space>', vim.lsp.buf.hover)

local os = vim.loop.os_uname().sysname
if os == 'Windows_NT' then
    -- Windows mappings
    -- Paste in insert mode
    vim.keymap.set('i', '<C-v>', '<C-r>+', { silent = true, noremap = true })
elseif os == 'Darwin' then
    -- MacOS mappings
    -- Paste in insert mode
    vim.keymap.set('i', '<M-v>', '<C-r>+', { silent = true, noremap = true })
end

-- Open lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- Open terminal
vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Toggle terminal' })

-- Replace without yank
vim.keymap.set('x', 'p', 'P', { silent = true, noremap = true })

-- Visual indent without losing selection
vim.keymap.set('v', '>', '>gv', { silent = true, noremap = true })
vim.keymap.set('v', '<', '<gv', { silent = true, noremap = true })

-- Save changes
vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>', { desc = 'Write changes' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit buffer' })
vim.keymap.set('n', '<leader>Q', '<cmd>q<cr>', { desc = 'Quit buffer (force)' })

-- Buffer navigation
vim.keymap.set('n', 'H', '<cmd>BufferPrevious<cr>', { silent = true, noremap = true })
vim.keymap.set('n', 'L', '<cmd>BufferNext<cr>', { silent = true, noremap = true })

-- Toggle term mappings
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- File explorer
vim.keymap.set('n', '<leader>e', function()
    local files = require('mini.files')
    files.open(vim.api.nvim_buf_get_name(0))
    files.reveal_cwd()
end)

-- Search and replace
vim.keymap.set('n', '<leader>fs', require('spectre').open, { desc = 'Search and replace' })

-- Text object remaps
local function alias_text_object(alias, text_object, desc_suffix)
    for _, m in pairs { 'v', 'o' } do
        for p, d in pairs { i = 'Inside', a = 'Around' } do
            vim.keymap.set(m, p .. alias, p .. text_object, { silent = true, noremap = true, desc = d .. desc_suffix })
        end
    end
end
alias_text_object('d', '"', 'double quotes')
alias_text_object('s', "'", 'single quotes')
alias_text_object('c', '{', 'curly braces')
