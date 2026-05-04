return {
  "rmagatti/auto-session",
  lazy = false,

  -- enables autocomplete for opts
  -- @module "auto-session"
  -- @type AutoSession.Config
  opts = {
    -- suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- log_level = 'debug',
    post_restore_cmds = {
      function()
        if vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) ~= "" then
          vim.cmd("silent! edit")
        end
      end,
    },
  },
}
