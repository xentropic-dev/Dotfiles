return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvimtree = require("nvim-tree")

        nvimtree.setup({
            open_on_tab = false,
            hijack_cursor = false,
            update_focused_file = {
                enable = true,
                update_cwd = false,
                ignore_list = {}
            },
            system_open = {
                cmd = nil,
                args = {}
            },
            view = {
                width = 30,
                side = "left",
            }
        })
    end,
    keys = {
        { "<leader>nt", "<cmd>NvimTreeToggle<CR>",   desc = "Toggle NvimTree" },
        { "<leader>nr", "<cmd>NvimTreeRefresh<CR>",  desc = "Refresh NvimTree" },
        { "<leader>nf", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in NvimTree" },
    }
}
