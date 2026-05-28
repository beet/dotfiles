-- Machine-specific overrides live in config/lsp_local.lua, also in this repo
-- (gitignored). Each machine defines its own server overrides there. The file
-- sits under config/ rather than plugins/ so LazyVim doesn't try to load it as
-- a plugin spec.
local local_opts = {}
pcall(function()
  local_opts = require("config.lsp_local")
end)

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Install rbenv and Ruby first, then `gem install ruby-lsp` before
        -- firing up nvim.
        ruby_lsp = vim.tbl_deep_extend("force", {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        }, local_opts.ruby_lsp or {}),
        marksman = {},
      },
    },
  },
}
