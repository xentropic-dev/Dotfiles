return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		local dapui = require("dapui")
		local dap = require("dap")

		-- <Alt-e> to evaluate expression
		vim.keymap.set({ "n", "v" }, "<M-e>", dapui.eval)
		dapui.setup()

		-- open Dap UI automatically when debug starts (e.g. after <F5>)
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		-- close Dap UI with :DapCloseUI
		vim.api.nvim_create_user_command("DapCloseUI", function()
			dapui.close()
		end, {})

		vim.keymap.set("n", "<F2>", function()
			dapui.close()
		end)
	end,
}
