local config = function()
  local telescope = require("telescope")

  -- Setup telescope with your defaults and extensions
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = true,
        hidden = true,
      },
      live_grep = {
        theme = "dropdown",
        previewer = true,
      },
      buffers = {
        theme = "dropdown",
        previewer = true,
      },
    },
    extensions = {
      file_browser = {
        theme = "ivy",       -- You can change this to other themes if preferred
        hijack_netrw = true, -- Replaces netrw with Telescope file browser
        mappings = {
          ["i"] = {
            -- Insert mode custom mappings (if any)
          },
          ["n"] = {
            -- Normal mode custom mappings (if any)
          },
        },
      },
    },
  })
  telescope.load_extension("file_browser")
end



return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.3",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim"
  },
  config = config,
  keys = {
    vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>"),
    vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>"),
    vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>"),
    vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>"),
    vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>"),
    vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>"),
  },
}
