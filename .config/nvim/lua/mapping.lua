builtin = require("telescope.builtin")
vim.keymap.set("n", "fr", builtin.oldfiles, { desc = "Find Recent Files" })
vim.keymap.set("n", "ff", builtin.find_files, { desc = "fuzzy find files" })
local live_grep = require("telescope").extensions.live_grep_args
vim.keymap.set("n", "fg", function() live_grep.live_grep_args() end, { desc = "live grep" })
vim.keymap.set("n",	"gr", builtin.lsp_references, { desc = "show lsp references" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "go to definition" })

-- exit from file
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { noremap = true, silent = true, desc = "Exit from file" })

-- toggle line wrap
vim.keymap.set("n", "<leader>z", ":set wrap!<CR>", { noremap = true, silent = true, desc = "Toggle line wrap" })

-- Don't yank with x or d or c
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')
-- also for visual mode
vim.keymap.set('v', 'c', '"_c')
vim.keymap.set('v', 'x', '"_x')

-- show diff
vim.keymap.set('n', 'di', [[:w !diff % -<CR>]], { noremap = true, silent = true, desc = "Show diff" })

-- show diag
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

-- buffer control (switching between files)
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>')
vim.keymap.set('n', '<leader>q', ':bdelete<CR>')
vim.keymap.set('n', '<leader><Tab>', ':Telescope buffers<CR>')

vim.keymap.set('n', '<leader>n', ':vnew<CR>', { noremap = true, silent = true, desc = 'Open new buffer' })

vim.keymap.set('n', 'rp', function() vim.cmd('!realpath %') end, { desc = 'Run realpath on current file' })

vim.keymap.set("n", "fd", ":Telescope projects<CR>", { desc = "show projects" })

vim.keymap.set("n", "tg",":GitBlameToggle<CR>", { desc = "toggle git blame log line, turn on / off" })

vim.keymap.set("n", "gb", ":GitBlameOpenCommitURL<CR>", { desc = "open git blame commit in browser" })

vim.keymap.set("n", "yh", ":Telescope yank_history<CR>", { desc = "telescope yank history" })

