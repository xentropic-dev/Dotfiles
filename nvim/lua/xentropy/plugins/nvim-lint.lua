return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters.zlint = {
			cmd = "zlint",
			stdin = false,
			append_fname = false,
			args = { "-f", "gh" },
			stream = "both",
			ignore_exitcode = true,
			parser = function(output, bufnr)
				local items = {}
				-- get buffer by file name
				for line in vim.gsplit(output, "\n") do
					local level, file, row, col, message =
						line:match("::(%w+)%sfile=([^,]+),line=(%d+),col=(%d+),title=(.*)")
					local severity = nil
					-- map linter levels to diagnostic levels
					-- zlint levels: error, warning, off
					if level == "error" then
						severity = vim.diagnostic.severity.ERROR
					elseif level == "warning" then
						severity = vim.diagnostic.severity.WARN
					end

					if file and severity then
						local l_bufnr = vim.fn.bufnr(file)
						if l_bufnr > -1 and l_bufnr == bufnr then
							table.insert(items, {
								lnum = tonumber(row) - 1,
								col = tonumber(col) - 1,
								message = message,
								source = "zlint",
								bufnr = bufnr,
								severity = severity,
							})
						end
					end
				end

				return items
			end,
		}
		lint.linters_by_ft = {
			zig = { "zlint" },
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
