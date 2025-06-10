return {
	"3rd/image.nvim",
	config = function()
		require("image").setup({
			backend = "kitty",
			kitty_method = "normal",
			integrations = {
				markdown = {
					filetypes = { "markdown" },
					enable = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_at_cursor = false,
					only_render_at_cursor_mode = "popup",
					floating_windows = false,
					resolve_image_path = function(document_path, image_path, fallback)
						-- document_path is the path to the file that contains the image
						-- image_path is the potentially relative path to the image. for
						-- markdown it's `![](this text)`

						-- you can call the fallback function to get the default behavior
						return fallback(document_path, image_path)
					end,
				},
			},
		})
	end,
}
