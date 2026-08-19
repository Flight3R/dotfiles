-- exit from file
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { noremap = true, silent = true, desc = "Exit from file" })
-- toggle line wrap
vim.keymap.set("n", "<leader>z", ":set wrap!<CR>", { noremap = true, silent = true, desc = "Toggle line wrap" })
-- Dont yank with x or d or c
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')
-- also for visual mode
vim.keymap.set('v', 'c', '"_c')
vim.keymap.set('v', 'x', '"_x')
-- keep the pasted text in the unnamed register when replacing a selection
vim.keymap.set('x', 'p', '"_dP', { desc = "Paste without overwriting the unnamed register" })
-- copy to system clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selected area to system clipboard" })
vim.keymap.set("n", "<leader>Y", ":%yank +<CR>", { desc = "Copy whole file to system clipboard" })
-- show diff
vim.keymap.set("n", "<leader>di", [[:w !diff % -<CR>]], { noremap = true, silent = true, desc = "Show diff" })
-- show diag
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
-- cd
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>", { desc = "cd to current file directory" })
-- buffer control (switching between files)
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
vim.keymap.set("n", "<leader>q", ":bdelete<CR>")
vim.keymap.set("n", "<leader>n", ":vnew<CR>", { noremap = true, silent = true, desc = "Open new buffer" })
-- realpath
local function copy_realpath()
  local file = vim.api.nvim_buf_get_name(0)
  local path = vim.trim(vim.fn.system({ "realpath", file }))
  path = '"' .. path .. '"'
  vim.fn.setreg("+", path)
  vim.notify("Copied path: " .. path)
end

vim.keymap.set("n", "<leader>rp", copy_realpath, { desc = "Copy realpath of current file to system clipboard" })
