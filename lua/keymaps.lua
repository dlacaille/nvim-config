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

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true, noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true, noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true, noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true, noremap = true })

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

-- Text object remaps
-- d as "
vim.keymap.set('v', 'id', 'i"', { silent = true, noremap = true, desc = 'Inside double quotes' })
vim.keymap.set('v', 'ad', 'a"', { silent = true, noremap = true, desc = 'Around double quotes' })
vim.keymap.set('o', 'id', 'i"', { silent = true, noremap = true, desc = 'Inside double quotes' })
vim.keymap.set('o', 'ad', 'a"', { silent = true, noremap = true, desc = 'Around double quotes' })

-- s as '
vim.keymap.set('v', 'is', "i'", { silent = true, noremap = true, desc = 'Inside single quotes' })
vim.keymap.set('v', 'is', "i'", { silent = true, noremap = true, desc = 'Inside single quotes' })
vim.keymap.set('o', 'as', "a'", { silent = true, noremap = true, desc = 'Around single quotes' })
vim.keymap.set('o', 'as', "a'", { silent = true, noremap = true, desc = 'Around single quotes' })

-- c as {
vim.keymap.set('v', 'ic', 'i{', { silent = true, noremap = true, desc = 'Inside curly braces' })
vim.keymap.set('v', 'ac', 'a{', { silent = true, noremap = true, desc = 'Around curly braces' })
vim.keymap.set('o', 'ic', 'i{', { silent = true, noremap = true, desc = 'Inside curly braces' })
vim.keymap.set('o', 'ac', 'a{', { silent = true, noremap = true, desc = 'Around curly braces' })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
