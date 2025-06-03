-- return {
-- 	"xentropic-dev/nvim-dotnet-explorer",
-- 	config = function()
-- 		require("dotnet_explorer").setup({
-- 			renderer = {
-- 				width = 40,
-- 				side = "right",
-- 			},
-- 		})
-- 	end,
-- 	keys = {
-- 		{ "<leader>ee", "<cmd>ToggleSolutionExplorer<cr>", desc = "Toggle Solution Explorer" },
-- 	},
-- }
return {
	dir = "~/plugins/nvim-dotnet-explorer",
	config = function()
		require("dotnet_explorer").setup({
			renderer = {
				width = 60,
				side = "left",
			},
		})
	end,
	keys = {
		{ "<leader>ee", "<cmd>ToggleSolutionExplorer<cr>", desc = "Toggle Solution Explorer" },
	},
}
