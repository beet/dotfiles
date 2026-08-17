return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}

-- return {
--   { "Shatur/neovim-ayu" },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "ayu-mirage",
--     },
--   },
-- }
