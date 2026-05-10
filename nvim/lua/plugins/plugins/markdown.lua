return {
	{
		-- Renderiza Markdown dentro de Neovim ocultando la sintaxis raw y mostrando un formato final elegante
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown", "markdown.mdx" },
		opts = {
			-- Puedes ajustar el estilo de los encabezados, listas, etc.
			heading = {
				sign = false,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)

			-- =========================================================================
			-- 🎨 CONFIGURACIÓN DE COLORES PARA RENDER-MARKDOWN
			-- =========================================================================
			-- Modifica los códigos HEX (#...) para cambiar los colores.
			local function apply_markdown_colors()
				-- 📌 Títulos (Niveles 1 al 6)
				-- fg = foreground (color del texto)
				-- bg = background (color de fondo). Ejemplo: bg = "#EAE4D3"

				-- Ejemplo de un H1 con texto violeta y fondo gris claro:
				-- local h1 = { fg = "#7A44BA", bg = "#EAE4D3", bold = true }
				local h1 = { fg = "#7A44BA", bold = true } -- Violeta
				local h2 = { fg = "#31748F", bold = true } -- Azul
				local h3 = { fg = "#427B58", bold = true } -- Verde
				local h4 = { fg = "#B56D0A", bold = true } -- Naranja/Amarillo
				local h5 = { fg = "#9D5B7A", bold = true } -- Rosa
				local h6 = { fg = "#5D5766", bold = true } -- Gris oscuro

				-- Cambiamos el color de los íconos de Render-Markdown
				vim.api.nvim_set_hl(0, "RenderMarkdownH1", h1)
				vim.api.nvim_set_hl(0, "RenderMarkdownH2", h2)
				vim.api.nvim_set_hl(0, "RenderMarkdownH3", h3)
				vim.api.nvim_set_hl(0, "RenderMarkdownH4", h4)
				vim.api.nvim_set_hl(0, "RenderMarkdownH5", h5)
				vim.api.nvim_set_hl(0, "RenderMarkdownH6", h6)

				-- Cambiamos el color del texto real (Treesitter)
				vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", h1)
				vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", h2)
				vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", h3)
				vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", h4)
				vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", h5)
				vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", h6)

				-- (Opcional) Sobrescribir colores genéricos por si no se usa Treesitter en algún buffer
				vim.api.nvim_set_hl(0, "markdownH1", h1)
				vim.api.nvim_set_hl(0, "markdownH2", h2)

				-- 📌 Fondos de Bloques de Código (```cpp, ```lua, etc.)
				-- #EAE4D3 es un tono ligeramente más oscuro que el fondo normal de tu tema claro (Lotus)
				vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#EAE4D3" })

				-- 📌 Código en línea (`codigo`)
				vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { fg = "#C34043", bg = "#EAE4D3" })
			end

			-- Aplicar los colores inmediatamente
			apply_markdown_colors()

			-- Asegurar que los colores no se borren si Neovim recarga el tema (ej. al abrir buffers)
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = apply_markdown_colors,
			})
		end,
		keys = {
			{ "<leader>rm", "<cmd>RenderMarkdown toggle<CR>", desc = "[R]ender [M]arkdown Toggle (Inline)" },
		},
	},
	{
		-- Renderiza Markdown en una pestaña del navegador con formato HTML en tiempo real
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "[M]arkdown [P]review Toggle (Browser)" },
		},
	},
}
