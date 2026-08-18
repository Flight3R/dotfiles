return {
     {
         "nvim-telescope/telescope.nvim",
         dependencies = {
             "nvim-lua/plenary.nvim",
             "Snikimonkd/telescope-git-conflicts.nvim",
             "nvim-telescope/telescope-live-grep-args.nvim",
         },
        keys = {
            { "fr", function() require("telescope.builtin").oldfiles() end, desc = "Find Recent Files" },
            { "ff", function() require("telescope.builtin").find_files() end, desc = "Fuzzy find files" },
            { "fg", function() require("telescope").extensions.live_grep_args.live_grep_args() end, desc = "Live grep" },
            { "gr", function() require("telescope.builtin").lsp_references() end, desc = "Show LSP references" },
            { "gd", function() require("telescope.builtin").lsp_definitions() end, desc = "Go to definition" },
            { "<leader><Tab>", function() require("telescope.builtin").buffers() end, desc = "Show buffers" },
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
    {
        "williamboman/mason.nvim",
        opts = {
            firewall = {
                enabled = true,
            },
        },
    },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "olimorris/codecompanion.nvim",
        version = "^19.0.0",
        cmd = {
            "CodeCompanion",
            "CodeCompanionActions",
            "CodeCompanionChat",
            "CodeCompanionCLI",
            "CodeCompanionCmd",
        },
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
            {
                "nvim-treesitter/nvim-treesitter",
                branch = "master",
                build = ":TSUpdate",
                opts = {
                    ensure_installed = { "yaml" },
                },
            },
        },
        opts = {
            interactions = {
                cli = {
                    agent = "codex",
                    agents = {
                        codex = {
                            cmd = "codex",
                            args = {},
                            description = "OpenAI Codex CLI",
                            provider = "terminal",
                        },
                    },
                },
            },
        },
        keys = {
            { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI: actions" },
            { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI: toggle chat" },
            { "<leader>ai", ":CodeCompanion ", mode = { "n", "v" }, desc = "AI: inline prompt" },
            { "<leader>al", "<cmd>CodeCompanionCLI<cr>", desc = "AI: open Codex CLI" },
            { "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "AI: add selection to chat" },
        },
    },

    -- Dont know why this
--    { "hrsh7th/nvim-cmp" }, -- The completion plugin
--    { "hrsh7th/cmp-buffer" }, -- Buffer completions
--    { "hrsh7th/cmp-path" }, -- Path completions
--    { "hrsh7th/cmp-cmdline" }, -- Cmdline completions
--    { "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
--    { "ray-x/lsp_signature.nvim" },
    {
        "f-person/git-blame.nvim",
        branch = "main",
        event = "VeryLazy",
        keys = {
            { "tg", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git blame line" },
            { "gb", "<cmd>GitBlameOpenCommitURL<cr>", desc = "Open Git commit URL" },
        },
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
        keys = {
            { "fd", "<cmd>Telescope projects<cr>", desc = "Show projects" },
        },
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
        keys = {
            { "yh", "<cmd>Telescope yank_history<cr>", desc = "Show yank history" },
        },
        config = function()
            require("yanky").setup({
                ring = {
                    history_length = 20,
                    storage = "memory",
                },
                system_clipboard = {
                    sync_with_ring = false,
                },
            })
            require("telescope").load_extension("yank_history")
        end
    },
 }
