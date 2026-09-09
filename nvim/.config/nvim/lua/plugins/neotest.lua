return {
  "nvim-neotest/neotest",

  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
  },

  config = function()
    -- Resolves via `brew --prefix`, not a hardcoded path, since this file is
    -- shared across machines (dotfiles) and Homebrew's prefix differs
    -- between Apple Silicon (/opt/homebrew) and Intel (/usr/local). This is
    -- the same opt-prefix symlink agent-monitor's own path resolution
    -- relies on, so it stays valid across `brew upgrade`. Returns nil (not
    -- an error) on a machine where agent-monitor/the formatter isn't
    -- installed, so neotest still works there with just its own formatter.
    local function agent_monitor_formatter_path()
      if vim.fn.executable("brew") == 0 then return nil end
      local prefix = vim.fn.system("brew --prefix agent-monitor"):gsub("%s+$", "")
      if vim.v.shell_error ~= 0 then return nil end
      local path = prefix .. "/share/agent-monitor/rspec_formatter.rb"
      if vim.fn.filereadable(path) == 0 then return nil end
      return path
    end

    require("neotest").setup({
      adapters = {
        -- neotest-rspec always passes its own `-f`/`-o` flags on the same
        -- rspec command line it builds; RSpec's option merging replaces
        -- (rather than merges) the formatter list across sources whenever
        -- one is given on the command line, so a project's .rspec-local
        -- --format entry never survives neotest-rspec's own run. Getting
        -- agent-monitor's formatter onto this *same* command line (via
        -- rspec_cmd, which neotest-rspec flattens together with its own
        -- flags into one command) is the only way both formatters end up
        -- in the same options source and actually coexist.
        require("neotest-rspec")({
          rspec_cmd = function()
            local cmd = { "bundle", "exec", "rspec" }
            local formatter_path = agent_monitor_formatter_path()
            if formatter_path then
              vim.list_extend(cmd, { "--require", formatter_path, "--format", "AgentMonitorRspecFormatter" })
            end
            return cmd
          end,
        }),
      },
      -- Project-wide discovery scans/parses every spec file in the repo, which on
      -- labmaster pegged the CPU and ballooned RAM. Tests are still found in files
      -- you open or run explicitly.
      discovery = {
        enabled = false,
      },
    })
  end,

  -- stylua: ignore
  keys = {
    {"<leader>t", "", desc = "+test"},
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  },
}
