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
                "tsserver",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "pyright",
                "omnisharp",
            },
            automatic_installation = true,
        })
    end
}
