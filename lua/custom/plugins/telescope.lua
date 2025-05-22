return {
  'nvim-telescope/telescope.nvim',
  opts = {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--glob=!**/node_modules/**',
        '--glob=!**/scripts/**',
        '--glob=!**/build/**',
        '--glob=!**/dist/**',
        '--glob=*.ts',
        '--glob=*.tsx',
      },
    },
  },
}
