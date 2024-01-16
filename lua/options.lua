-- Make line numbers default
vim.o.number = true

-- Configure title
vim.o.title = true
vim.o.titlestring = "nvim in %{substitute(getcwd(), $HOME, '~', '')}"

-- Enable mouse mode
vim.o.mouse = 'a'
vim.o.mousemoveevent = true

-- Default tab size
vim.o.tabstop = 4 -- make tabs 4 spaces wide
vim.o.shiftwidth = 4 -- tab should insert 4 spaces
vim.o.expandtab = true -- use spaces by default

-- Set terminal output lines to 2
vim.o.cmdheight = 2

-- Always show 5 lines at start/end of buffer
vim.o.scrolloff = 5

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Hide ~ characters after end of buffer
vim.wo.fillchars = 'eob: '

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Use treesitter for folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
