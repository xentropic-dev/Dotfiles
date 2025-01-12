return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.zig = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
		-- nvim dap mappings
		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<F10>", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<F11>", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<F12>", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<M-b>", function()
			dap.toggle_breakpoint()
		end)

		local sign = vim.fn.sign_define

		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
	end,
}
