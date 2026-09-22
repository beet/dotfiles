-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Jump between a Ruby file and its spec. ruby-lsp answers a custom request,
-- experimental/goToRelevantFile, which globs for test/spec siblings and picks
-- the candidate whose directory parts overlap the current file's the most, so
-- app/models/user.rb lands on spec/models/user_spec.rb rather than
-- spec/requests/user_spec.rb. It works in both directions. Neotest can't do
-- this -- it only knows about tests it has already discovered, and discovery is
-- disabled for performance.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function(ev)
    vim.keymap.set("n", "<leader>ta", function()
      local client = vim.lsp.get_clients({ bufnr = ev.buf, name = "ruby_lsp" })[1]
      if not client then
        return vim.notify("ruby-lsp is not attached to this buffer", vim.log.levels.WARN)
      end

      local params = { textDocument = vim.lsp.util.make_text_document_params(ev.buf) }
      -- lua_ls types the method as the union of standard LSP methods, so a
      -- custom request trips param-type-mismatch. It's valid at runtime.
      ---@diagnostic disable-next-line: param-type-mismatch
      client:request("experimental/goToRelevantFile", params, function(err, result)
        local locations = result and result.locations or {}
        if err or vim.tbl_isempty(locations) then
          return vim.notify("No relevant file found", vim.log.levels.WARN)
        end

        -- The response is a list of absolute paths, not LSP Locations, so open
        -- them directly instead of going through vim.lsp.util.
        if #locations == 1 then
          return vim.cmd.edit(vim.fn.fnameescape(locations[1]))
        end

        vim.ui.select(locations, {
          prompt = "Relevant file",
          format_item = function(path)
            return vim.fn.fnamemodify(path, ":.")
          end,
        }, function(choice)
          if choice then
            vim.cmd.edit(vim.fn.fnameescape(choice))
          end
        end)
      end, ev.buf)
    end, { buffer = ev.buf, desc = "Go to Relevant File (ruby-lsp)" })
  end,
})
