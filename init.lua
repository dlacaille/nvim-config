-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local utils = require('utils')

require('lazy-init')
require('options')
require('keymaps')
require('lsp-config')
utils.require_all('config/*.lua')
utils.require_all('lang/*.lua')
