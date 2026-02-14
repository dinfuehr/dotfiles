vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.dora',
  command = 'set filetype=dora',
})
