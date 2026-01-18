return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        },
      },
    },
  },
}

-- local nvim_lsp = require("lspconfig")
-- -- local cmp = require("cmp_nvim_lsp")
-- -- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- -- If they're not working, try running `gem install solargraph` and `gem install ruby-lsp`
-- -- ruby-lsp requires ruby version 2.7.3 or higher and nvim 0.10.0
-- nvim_lsp.ruby_lsp.setup({
--   cmd = { "/Users/markbeattie/.rbenv/shims/ruby-lsp" },
--   -- capabilities = cmp.default_capabilities(capabilities),
-- })
--
-- return {}
