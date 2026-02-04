return {
  "andev0x/sql-formatter.nvim",
  ft = { "sql", "mysql", "plsql", "pgsql" },

  config = function()
    vim.g.sqlformat_command = "sqlformat"
    vim.g.sqlformat_options = "--reindent --keywords upper --identifiers lower --strip-comments"
    vim.g.sqlformat_prog = "sqlformat"

    require("sql-formatter").setup({
      keybindings = {
        format_buffer = "<leader>sf",
        format_selection = "<leader>ss",
        toggle_format_on_save = "<leader>st",
      },
    })
  end,
}
