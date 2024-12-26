return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,

    config = function()
        require("nvim-treesitter.configs").setup {
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- assignments
                        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        ["l="] = { query = "@assignment.lhs", desc = "Select left-hand side of an assignment" },
                        ["r="] = { query = "@assignment.rhs", desc = "Select right-hand side of an assignment" },

                        -- comments
                        ["a/"] = { query = "@comment.outer", desc = "Select outer comment" },
                        ["i/"] = { query = "@comment.inner", desc = "Select inner comment" },

                        -- functions
                        ["af"] = { query = "@function.outer", desc = "Select outer function" },
                        ["if"] = { query = "@function.inner", desc = "Select inner function" },

                        -- call
                        ["ap"] = { query = "@call.outer", desc = "Select outer call" },
                        ["ip"] = { query = "@call.inner", desc = "Select inner call" },

                        -- loops
                        ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner loop" },

                        -- class
                        ["ac"] = { query = "@class.outer", desc = "Select outer class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner class" },

                        -- arguments
                        ["aa"] = { query = "@argument.outer", desc = "Select outer argument" },
                        ["ia"] = { query = "@argument.inner", desc = "Select inner argument" },

                        -- conditional
                        ["ai"] = { query = "@conditional.outer", desc = "Select outer conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },

                    },
                },
            },
        }
    end,
}
