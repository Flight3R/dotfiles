return {
    {
 		"nvim-telescope/telescope.nvim",
 		tag = "0.1.8",
 		dependencies = {
 			"nvim-lua/plenary.nvim",
 			"Snikimonkd/telescope-git-conflicts.nvim",
 			"nvim-telescope/telescope-live-grep-args.nvim",
 		},
 	},
 	-- file browser for telescope
 	{
 		"nvim-telescope/telescope-file-browser.nvim",
 		dependencies = {
 			"nvim-telescope/telescope.nvim",
 			"nvim-lua/plenary.nvim",
 		},
 	},
    -- Lualine status bar
    { 
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    { "neovim/nvim-lspconfig" },
    -- Mason for lsp config
--	{ "williamboman/mason.nvim" },
--	{ "williamboman/mason-lspconfig.nvim" },

    -- Dont know why this
--	{ "hrsh7th/nvim-cmp" }, -- The completion plugin
--	{ "hrsh7th/cmp-buffer" }, -- Buffer completions
--	{ "hrsh7th/cmp-path" }, -- Path completions
--	{ "hrsh7th/cmp-cmdline" }, -- Cmdline completions
--	{ "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
--	{ "ray-x/lsp_signature.nvim" },
    {
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = " <summary> • <date> • <author> • <<sha>>",
			date_format = "%d-%m-%Y %H:%M:%S",
			virtual_text_column = 1,
		},
	},
    -- projects in nvim
    {
        "ahmedkhalf/project.nvim",
        lazy = false,
        config = function()
            require("project_nvim").setup({
                detection_methods = { "pattern" },
                patterns = { ".git", ".nvim" },
                show_hidden = true,
            })
        end,
    },
    -- yank history
    {
        "gbprod/yanky.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("yanky").setup()
            require("telescope").load_extension("yank_history")
        end
    },
 }
