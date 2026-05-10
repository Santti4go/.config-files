return {
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next [C]hange" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Prev [C]hange" })

				-- Actions
				-- visual mode
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git [s]tage hunk" })
				map("v", "<leader>ghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git [r]eset hunk" })
				-- normal mode
				map("n", "<leader>ghs", gs.stage_hunk, { desc = "Git [s]tage hunk" })
				map("n", "<leader>ghr", gs.reset_hunk, { desc = "Git [r]eset hunk" })
				map("n", "<leader>ghS", gs.stage_buffer, { desc = "Git [S]tage buffer" })
				map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Git [u]ndo stage hunk" })
				map("n", "<leader>ghR", gs.reset_buffer, { desc = "Git [R]eset buffer" })
				map("n", "<leader>ghp", gs.preview_hunk, { desc = "Git [p]review hunk" })
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = false })
				end, { desc = "Git [b]lame line" })
				map("n", "<leader>ghd", gs.diffthis, { desc = "Git [d]iff this" })
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, { desc = "Git [D]iff this ~" })

				-- Toggles
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[T]oggle git [b]lame line" })
				map("n", "<leader>td", gs.toggle_deleted, { desc = "[T]oggle git [d]eleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git [i]nner [h]unk" })
			end,
		},
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true,
				},
			})
			vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>", { desc = "Git [S]tatus (Neogit)" })
		end,
	},

	{
		"sindrets/diffview.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git [D]iffview Open" })
			vim.keymap.set("n", "<leader>gx", "<cmd>DiffviewClose<CR>", { desc = "Git E[x]it/Close Diffview" })
			vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git [H]istory (current file)" })
		end,
	},
}
