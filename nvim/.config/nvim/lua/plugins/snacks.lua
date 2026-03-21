-- https://fabiorehm.com/blog/2025/11/20/neovim-lazyvim-rails-ssh/
-- Snacks configuration
-- Explorer: Show hidden and gitignored files by default
-- File pickers (<space>ff, <space><space>): Show hidden files, respect .gitignore
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- Show hidden files (dotfiles)
            ignored = true, -- Show gitignored files
          },
          files = {
            hidden = true, -- Show hidden files in file picker
            -- Note: Gitignored files intentionally excluded from fuzzy finders
            -- This is standard behavior - keeps search results focused
          },
        },
      },
    },
  },
}
