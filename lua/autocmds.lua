-- Reload the current buffer if it has changed.
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'CursorHoldI', 'FocusGained' }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { '*' },
})
