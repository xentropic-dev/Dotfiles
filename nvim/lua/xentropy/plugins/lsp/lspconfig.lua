return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {},
		},
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		local x = vim.diagnostic.severity

		vim.diagnostic.config({
			virtual_text = { prefix = "" },
			signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
			underline = true,
			float = { border = "single" },
		})
		-- Function to restart mojo LSP server if it crashes
		local function restart_mojo_lsp()
			-- Use `vim.schedule` to safely run the LspStart command
			vim.schedule(function()
				print("Restarting mojo-lsp-server...")
				vim.cmd("LspStart mojo")
			end)
		end

		local util = require("lspconfig.util")
		local omnisharp_bin = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp"

		local lsp_opts = {
			servers = {
				mojo = {
					root_dir = function(fname)
						-- Use lspconfig's utility function to search for mojoproject.toml in parent directories
						return util.root_pattern("mojoproject.toml")(fname)
							or util.find_git_ancestor(fname)
							or vim.fn.getcwd()
					end,
					-- Additional configuration (if needed)
					on_attach = function(client, _)
						print("Mojo LSP attached to " .. client.name)
					end,
					-- This is a workaround for the fact that the mojo lsp server
					-- keeps crashing in neovim as of 12/2024.  I have an open issue
					-- but no progress is being made.
					on_exit = function(_, code, _)
						if code ~= 0 then
							print("mojo-lsp-server has crashed, restarting...")
							restart_mojo_lsp()
						end
					end,
				},
				zls = {
					cmd = { "zls" },
					settings = {
						zls = {
							enable_build_on_save = true,
						},
					},
				},
				ts_ls = {},
				lua_ls = {
					on_attach = function(client, bufnr)
						--- This forces lua_ls to provide diagnostics for the entire workspace
						--- instead of just the open buffers.  Handy for jumping through diagnostics
						--- in a large project.
						require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
					end,
				},
				omnisharp = {
					cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
					enable_import_completion = true,
					organize_imports_on_format = true,
					enable_roslyn_analyzers = true,
					root_dir = util.root_pattern("*.sln", "*.csproj", ".git"),
					-- enable_import_completion = true,
					-- organize_imports_on_format = true,
					-- enable_roslyn_analyzers = true,
					-- root_dir = function()
					-- 	return util.root_pattern(
					-- 		"*.sln",
					-- 		"*.csproj",
					-- 		"Directory.Build.props",
					-- 		"Directory.Build.targets"
					-- 	)(vim.fn.getcwd())
					-- end,
					-- enable_decompilation_support = true,
					-- filetypes = {
					-- 	"cs",
					-- 	"vb",
					-- 	"csproj",
					-- 	"sln",
					-- 	"slnx",
					-- 	"props",
					-- 	"csx",
					-- 	"targets",
					-- 	"tproj",
					-- 	"slngen",
					-- 	"fproj",
					-- },
				},
			},
		}
		local lspconfig = require("lspconfig")
		local blink_cmp = require("blink.cmp")

		for server, config in pairs(lsp_opts.servers) do
			config.capabilities = blink_cmp.get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,
}
