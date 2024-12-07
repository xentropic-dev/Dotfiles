return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
                if not require("noice.lsp").scroll(4) then
                    return "<c-f>"
                end
            end, { silent = true, expr = true })

            vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
                if not require("noice.lsp").scroll(-4) then
                    return "<c-b>"
                end
            end, { silent = true, expr = true })
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                    documentation = {
                        view = "hover",
                        opts = { -- lsp_docs settings
                            replace = true,
                            format = { "{message}" },
                            position = { row = 2, col = 2 },
                            size = {
                                max_width = 80,
                                max_height = 15,
                            },
                            border = {
                                style = "rounded",
                            },
                            win_options = {
                                concealcursor = "n",
                                conceallevel = 3,
                                winhighlight = {
                                    Normal = "CmpPmenu",
                                    FloatBorder = "DiagnosticSignInfo",
                                },
                            },
                        },
                    },
                }
            })
        end,
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 5000
        },
    }
}
