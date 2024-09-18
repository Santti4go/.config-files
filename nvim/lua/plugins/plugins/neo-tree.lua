return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		vim.keymap.set("n", "<leader>b", ":Neotree toggle source=filesystem reveal position=left<CR>")
		vim.keymap.set("n", "<leader>B", ":Neotree toggle source=filesystem reveal position=left action=show<CR>")
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			window = {
				mappings = {
					["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
					["<C-F>"] = { "scroll_preview", config = { direction = 10 } },
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "✚",
						deleted = "✖",
						modified = "[M]",
						renamed = "[r]",
						-- Status type
						untracked = "u",
						ignored = "",
						conflict = "[!]",
					},
				},
				icon = {
					provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
						if node.type == "file" or node.type == "terminal" then
							local success, web_devicons = pcall(require, "nvim-web-devicons")
							local name = node.type == "terminal" and "terminal" or node.name
							if success then
								local devicon, hl = web_devicons.get_icon(name)
								icon.text = devicon or icon.text
								icon.highlight = hl or icon.highlight
							end
						end
					end,
				},
			},
		})
	end,
}
