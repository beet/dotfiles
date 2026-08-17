-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- local opt = vim.opt

vim.g.snacks_animate = false

vim.opt.relativenumber = false

vim.o.winborder = "rounded"

-- Folding is left to LazyVim, which already sets foldmethod=expr with its own
-- guarded foldexpr (require'lazyvim.util'.ui.foldexpr()). That version returns
-- early for buffers with no active treesitter parser, so it skips the parse cost
-- on large/non-code buffers. The raw vim.treesitter.foldexpr() override that was
-- here dropped that guard, making every buffer open/close recompute folds -- a
-- CPU spike on exactly those events.
