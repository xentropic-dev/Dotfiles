return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		mason.setup({
			ui = {
				icons = {
					package_installed = "",
					package_uninstalled = "",
					package_pending = "",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"html",
				"lua_ls",
				"pyright",
				"omnisharp",
				"zls",
				"prettier",
				"yq",
				"unocss-language-server",
			},
			automatic_installation = true,
		})
	end,
}
