local servers = {
	"rust_analyzer",
	"clangd",
--	"jdtls",
	"lua_ls",
--	"marksman",
--	"omnisharp",
	"pyright",
	"ruff",
	"bashls",
--    "gopls"
}

require("mason").setup() -- Initialize mason
require("mason-lspconfig").setup({
	ensure_installed = servers,
})
-- Function to attach to every LSP server
local on_attach = function(client, bufnr) end

local lspconfig = require("lspconfig")

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
	})
end
