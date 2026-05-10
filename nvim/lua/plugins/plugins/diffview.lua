return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open (Git Diff)" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History (Current File)" },
    { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
  },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function(bufnr)
          -- Configuraciones específicas al abrir el buffer de diff
          vim.opt_local.wrap = false
        end,
      },
    })
  end,
}
