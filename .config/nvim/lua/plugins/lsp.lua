return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },  

  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },  
    dependencies = {
      {"mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "b0o/schemastore.nvim",
    },
    opts = {
      ensure_installed = {
      --- PYTHON  
      "ruff",
      "pyright",
      "basedpyright",
      "ty",
      "pyrefly",
      --- YAML/ JSON
      "yamlls",
      "jsonls",
      --- JS/ TS
      "ts_ls",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      require("lsp").setup()
    end,
  },
}
