return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Biome como formatter
        null_ls.builtins.formatting.biome.with({
          command = "biome", -- path para o binário, se necessário
          args = { "format", "--stdin-file-path", "$FILENAME" },
        }),
      },
    })

    require("mason-null-ls").setup({
      ensure_installed = { "biome" },
      automatic_installation = false,
    })
  end,
}
