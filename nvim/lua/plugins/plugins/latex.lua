return {
	"lervag/vimtex",
	-- "neovim/nvim-lspconfig",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
	end,
}
