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
			window = {
				mappings = {
					["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
					["<C-F>"] = { "scroll_preview", config = { direction = 10 } },
				},
			},
		})
	end,
}
