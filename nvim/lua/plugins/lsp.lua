return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",
        "jsonls",
      },
      automatic_installation = true,
    },
  },
}
