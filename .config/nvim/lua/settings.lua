vim.opt.number = true
vim.opt.relativenumber = false

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.opt.ignorecase = true

--
vim.o.showmode = false
vim.g.netrw_keepdir = 0

vim.o.splitright = true

local actions = require("telescope.actions")

require("telescope").setup({
    pickers = {
        find_files = {
            hidden = true,
        },
    },
    defaults = {
        file_ignore_patterns = { ".git/" },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        mappings = {
           i = {
                ["<C-q>"] = function(prompt_bufnr)
                    actions.send_selected_to_qflist(prompt_bufnr)
                    vim.cmd("copen")
                end,
            },
            n = {
                ["<C-q>"] = function(prompt_bufnr)
                    actions.send_selected_to_qflist(prompt_bufnr)
                    vim.cmd("copen")
                end,
            }
        },
    },
})

require("telescope").load_extension("conflicts")
require("telescope").load_extension("projects")

require("lualine").setup({
  options = {
    icons_enabled = false,
    section_separators = "",
    component_separators = "|",
  }
})

-- set vim to use system clipboard
if vim.fn.has("unnamedplus") == 1 then
	vim.o.clipboard = "unnamedplus"
else
	vim.o.clipboard = "unnamed"
end

-- ignore DS_Store files
vim.opt.wildignore:append("*/.DS_Store")

-- transparent background
vim.o.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
