local M = {}

-- globs to exclude from grep
M.live_grep_globs = {
  '--glob=!.git/**',
  '--glob=!node_modules/**',
  '--glob=!tests/**',
  '--glob=!stories/**',
  '--glob=!dist/**',
  '--glob=!wwwroot/build/**',
  '--glob=!wwwroot/scripts/*',
  '--glob=!wwwroot/test-results/*',
  '--glob=!*-lock.json',
  '--glob=!*.png',
  '--glob=!*.jpg',
  '--glob=!*.svg',
  '--glob=!*.pdf',
}

return M
