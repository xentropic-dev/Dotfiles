return {
    "github/copilot.vim",
    build = ":Copilot setup",
    config = function()
        vim.g.copilot_no_tab_map = true
        vim.api.nvim_set_keymap("i", "<C-a>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Cancel()', { silent = true, expr = true })
    end
}
