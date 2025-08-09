return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      filetype = {
        javascript = "node $file",
        typescript = "ts-node $file",
        python = "python3 $file",
        lua = "lua $file",
        java = "javac $fileName && java $fileNameWithoutExt",
        bash = "bash $file",
      },
    })

    vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { desc = "Run code", silent = true })
  end,
  cmd = { "RunCode", "RunFile" },
}

