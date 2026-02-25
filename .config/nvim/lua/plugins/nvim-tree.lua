return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  opts = {
    filters = {
      dotfiles = false,
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
