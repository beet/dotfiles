return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Install rbenv and Ruby first, then `gem install ruby-lsp` before
        -- firing up nvim.
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        },
        marksman = {},
      },
    },
  },
}
