-- Set leader key first (before lazy.nvim)
vim.g.mapleader = ","

-- Bootstrap and load lazy.nvim
require("config.lazy")

-- Settings
vim.opt.hidden = true           -- allows switching from unsaved buffer
vim.opt.number = true           -- use line numbers
vim.opt.relativenumber = true   -- use relative line numbers
vim.opt.undofile = true         -- allow undo even after file was closed
vim.opt.termguicolors = true    -- enable true color support
vim.opt.wildmode = { 'longest', 'list', 'full' }
vim.opt.wildmenu = true
vim.opt.list = true             -- show invisible characters
vim.opt.listchars = { tab = '▸ ', eol = '¬' }

-- Keymaps
-- use perl regexes for searching
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('v', '/', '/\\v')

-- use ctrl-p to load files
vim.keymap.set('n', '<C-p>', ':FuzzyOpen<CR>')

-- switch between buffers with tab and shift-tab
vim.keymap.set('n', '<tab>', ':bn<CR>')
vim.keymap.set('n', '<S-tab>', ':bp<CR>')

-- j/k jumps with count work normally, without count use gj/gk
vim.keymap.set('n', 'j', function() return vim.v.count == 0 and 'gj' or 'j' end, { expr = true, silent = true })
vim.keymap.set('n', 'k', function() return vim.v.count == 0 and 'gk' or 'k' end, { expr = true, silent = true })

-- remove highlighting
vim.keymap.set('n', '<leader><space>', ':noh<cr>')

-- space means :
vim.keymap.set('n', '<space>', ':')

-- Dora LSP configuration (requires Neovim 0.11+)
if vim.fn.has('nvim-0.11') == 1 then
  vim.lsp.config['dorals'] = {
    cmd = { '/home/dominik/.dora/bin/dora-language-server' },
    filetypes = { 'dora' },
    root_markers = { '.git' }
  }
  vim.lsp.enable('dorals')
end
