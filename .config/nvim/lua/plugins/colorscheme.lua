return {
  "catppuccin/nvim",
  lazy = false,
  priority = 999,
  config = function()
    -- Optional: Setup for customizing the theme
    require("catppuccin").setup({
      flavour = "mocha",             -- choose from latte, frappe, macchiato, mocha
      transparent_background = true, -- set to true for a transparent background
    })

    -- Set the colorscheme
    vim.cmd('colorscheme catppuccin')
  end
}
