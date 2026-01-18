if true then
  return {}
end

return {
  "vim-test/vim-test",

  config = function()
    -- Run specs in a persistent split pane
    vim.g["test#neovim#start_normal"] = 1
    vim.g["test#strategy"] = "neovim_sticky"

    -- Doesn't seem to do anything:
    vim.g["test#neovim_sticky#reopen_window"] = 1
  end,

  -- keys = {
  --   { "<leader>t", "", desc = "+test" },
  --   { "<leader>tt", ":TestFile<CR>", desc = "Run File (test.vim)" },
  --   -- { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
  --   { "<leader>tr", ":TestNearest<CR>", desc = "Run Nearest (test.vim)" },
  --   { "<leader>tl", ":TestLast<CR>", desc = "Run Last (test.vim)" },
  --   -- { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
  --   -- { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
  --   -- { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
  --   -- { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
  --   -- { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  -- },
}
