local M = {}

M.ignore_patterns = {
  '%.lock',
  '%.jpg',
  '%.jpeg',
  '%.png',
  '%.svg',
  '%.otf',
  '%.ttf',
  '%.min.js',
  'node_modules',
  'dist',
}

M.ts_globs = {
  '--glob=*.ts',
  '--glob=*.tsx',
}
