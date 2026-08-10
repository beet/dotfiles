-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Neovim detects *.tfvars as the `terraform-vars` filetype, which has no
-- syntax file. Map it to `terraform` so it uses the built-in terraform syntax
-- (same highlighting our .tf files already get).
vim.filetype.add({
  pattern = { [".*%.tfvars"] = "terraform" },
})
