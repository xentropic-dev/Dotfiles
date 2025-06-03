return {
	dir = "~/src/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			zig = { "zlint" },
			cs = { "resharper" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})

		vim.api.nvim_create_autocmd({ "BufRead" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
