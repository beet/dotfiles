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
    -- keys = {
    --   {
    --     "<leader>lr",
    --     function()
    --       -- nvim 0.12 / LazyVim has no :LspRestart command, so drive the native
    --       -- API. enable(name, false) stops the client; re-enabling retriggers
    --       -- the FileType autocmd on open buffers and reattaches. Defer the
    --       -- re-enable so the old client finishes its async shutdown first --
    --       -- otherwise start() reuses the still-dying client instead of a fresh one.
    --       vim.lsp.enable("ruby_lsp", false)
    --       vim.defer_fn(function()
    --         vim.lsp.enable("ruby_lsp")
    --       end, 500)
    --     end,
    --     desc = "Restart ruby-lsp",
    --   },
    -- },
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Stop *every* LSP server from registering workspace file watchers.
        -- Neovim's watcher runs in-process and, on macOS, recursively watches
        -- the whole workspace root -- tmp/, log/, node_modules/, .git/ included.
        -- When those churn, the fs-event flood saturates nvim's event loop and
        -- grows its memory, so nvim itself pins the CPU and creeps past 1GB (the
        -- server process stays small). The "*" pseudo-server applies these
        -- capabilities to every server, covering marksman and lua_ls too; a
        -- per-server override on ruby_lsp alone left marksman re-arming the same
        -- whole-repo watch. Servers skip watcher registration when the client
        -- doesn't advertise dynamicRegistration. (Top-level opts.capabilities is
        -- deprecated in favor of servers["*"].capabilities.)
        -- ["*"] = {
        --   capabilities = {
        --     workspace = {
        --       didChangeWatchedFiles = { dynamicRegistration = false },
        --     },
        --   },
        -- },
        -- Install rbenv and Ruby first, then `gem install ruby-lsp` before
        -- firing up nvim.
        ruby_lsp = vim.tbl_deep_extend("force", {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
          init_options = {
            -- These probably aren't worth disabling for performance:
            -- codeLens = false,
            -- documentLink = false,
            -- inlayHint = false,
            -- onTypeFormatting = false,
            -- typeHierarchy = false,
            -- enabledFeatures = {
            --   semanticHighlighting = false,
            -- },
          },
        }, local_opts.ruby_lsp or {}),
        marksman = {},
      },
    },
  },
}
