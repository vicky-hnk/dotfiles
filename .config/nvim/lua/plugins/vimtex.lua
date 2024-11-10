return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- Configure VimTeX to use Zathura as the PDF viewer
    vim.g.vimtex_view_method = "zathura"
    -- Use latexmk for compiling, which comes with TeX Live
    vim.g.vimtex_compiler_method = "latexmk"
  end,
}
