-- https://fabiorehm.com/blog/2025/11/20/neovim-lazyvim-rails-ssh/
-- Snacks configuration
-- Explorer: Show hidden and gitignored files by default
-- File pickers (<space>ff, <space><space>): Show hidden files, respect .gitignore
-- The logo is 63 cells wide; each pane carries one half of it, so the two key columns sit
-- under it with no gap tearing the image apart. That is why pane_gap is 0.
local PANE_WIDTH = 32
local PANE_GAP = 0
-- snacks centres an over-wide pane-1 line on pane 1 alone; this much left indent moves such
-- a line to the middle of the two-pane block instead.
local CENTRE = PANE_WIDTH + PANE_GAP

local ART = [[
⠀⠀⠀⠀⠐⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⢴⢄⡀⠀⠈⢰⡟⡛⠳⣦⣴⠟⢛⣻⠀⠀⠀⣠⡴⠆⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠂
⠀⠀⠀⠀⠀⠀⠀⠀⠈⡁⠀⠀⠰⠀⠾⠆⠲⠂⣠⠾⠛⣳⣤⡙⢦⣄⠀⠙⢉⡶⠋⣠⣆⡙⠉⠀⣠⡾⢋⣴⣟⢙⢷⣄⠀⠶⠐⠷⠀⠶⠀⠀⠈⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢰⡟⢳⣆⠁⢤⣤⣬⣥⣤⣤⣤⣤⣤⣤⣤⣾⣷⣧⣾⣥⣬⣿⣦⡙⢷⣄⠻⢦⠞⣡⠾⢋⣤⠞⣋⣴⣿⣥⣭⣷⣵⣽⣷⣤⣤⣤⣤⣤⣤⣤⣤⣥⣤⣤⠄⣠⣾⢛⡦⠀⠀
⠀⠈⣻⢷⣌⠻⣦⣻⣤⡙⠻⠶⠦⠤⠤⠤⠤⠴⠤⣤⣤⣴⡿⠿⠛⣻⣦⡽⢷⣬⠟⣁⡴⠻⣥⣾⣟⠻⠿⠷⢤⣤⡤⠤⠦⠤⣤⡤⠤⠤⠴⠶⠞⢉⣴⣣⠞⢋⣼⣿⠁⠀⠀
⠀⠀⣿⠀⣏⣷⠾⠿⢿⡿⣷⡶⣶⣶⠖⠀⢀⣵⣿⡿⠟⠉⣠⣶⣿⣛⣛⡿⠞⣡⡾⣏⣷⣄⠈⠻⣿⣿⡶⣶⣶⣤⠹⣦⡀⠀⡏⠙⠷⣶⣶⢶⡾⣿⠟⣡⣾⣻⡇⣸⠆⠀⠀
⠀⠀⠹⣶⣏⣴⣞⢻⣦⠹⢸⣿⡿⠁⢀⣴⣿⡿⠋⠀⣠⣾⣯⠹⣿⡽⢋⣴⡞⢯⣳⠞⣿⡏⠳⣄⠈⠛⣿⣌⡳⣿⠇⣿⠙⢦⣿⣶⣄⠈⠙⢿⣷⡏⣼⠻⣦⠟⣠⡟⠀⠀⠀
⠀⠀⢀⡼⢋⣴⡛⠛⢋⣴⣿⠏⠀⣠⣿⣿⠟⠁⢀⣾⠿⣏⢻⣷⣘⠳⣿⣦⠽⠚⣡⡾⢿⡇⠀⢻⣷⣄⠈⠻⣷⣏⣴⣿⣄⠀⠙⢿⣿⣷⣄⠀⠹⣷⡟⢛⣡⣾⢿⣄⠀⠀⠀
⠀⢀⡿⢠⡿⣟⢛⣿⣿⣿⠇⠀⣸⣿⣿⠟⠀⢠⣿⣇⠀⠻⣇⢻⣿⣧⣤⣤⣤⣿⠟⠀⣿⡇⠀⢿⣿⣿⣧⡀⠘⣿⣇⣿⠘⢧⡀⠀⠻⣿⣿⣧⠀⠘⣿⡟⣣⠿⣄⠻⣄⠀⠀
⠀⢸⣤⣿⣷⣌⠻⣅⣽⠃⠀⣼⣿⣿⠏⠀⣰⠟⣿⡿⣷⡄⠈⠻⣿⣿⣯⡿⠋⠀⡀⠀⢾⡇⠀⣻⣿⠟⠉⣻⣆⠈⢿⣿⠀⠈⣿⣦⡀⠙⢿⣿⣷⡀⠈⢿⣅⡼⣻⣇⡿⠀⠀
⠀⠀⠙⢯⣊⣼⢷⡾⠁⠀⣼⣿⣿⠃⠀⣴⡏⠀⠹⣿⣿⡟⢦⡀⠈⠻⣏⠀⣠⣾⡇⠀⣻⡇⠀⣽⡏⢀⣾⢟⢿⣧⠈⣿⠀⠀⣿⣿⣷⡄⠀⢻⣿⡷⠀⠀⢻⡌⣺⠏⠀⠀⠀
⠀⠀⢀⡼⢛⣧⡿⠁⢀⣾⢟⣽⠃⠀⣼⣟⣿⡄⠀⢻⣿⡇⠀⣿⣦⡀⠘⢿⣿⣿⡇⠀⣽⡇⠀⢼⠀⢸⣷⢞⠢⣿⠄⢸⠀⠀⣿⡿⠋⠀⣠⡶⠋⠀⣠⣾⣯⡟⢷⡀⠀⠀⠀
⠀⠀⣾⢡⣾⡟⠀⢀⣾⣻⡿⠁⢀⡾⠛⠛⠛⢷⡀⠈⢿⡇⠀⣿⣿⣷⣄⠀⠙⢿⡇⠀⢾⣧⡀⢺⡇⠈⣿⣯⣿⡟⠐⣾⠀⠀⣿⣷⣄⠈⠹⢦⣠⣾⠟⣩⣍⢻⡆⢻⠀⠀⠀
⠀⠀⢿⣸⡟⠀⢀⣾⣿⡿⠁⢀⣾⣷⣶⣶⣶⣾⣧⠀⠘⣧⡀⣿⣯⢹⣻⣷⣄⠀⠙⢦⣻⡇⠙⣿⣿⣆⠈⠻⣏⢀⣼⣿⠀⢀⣿⣟⢻⣷⣄⠈⠻⣿⣆⣛⣋⣼⠇⣼⠁⠀⠀
⠀⠀⠈⣿⠀⢀⡾⠻⣿⠁⢀⣾⡿⣡⣞⠻⣤⡙⣿⣇⠀⠘⣷⣿⣿⠳⣿⣽⣿⣦⡀⠈⣿⢧⡀⠈⠻⣿⣷⣄⠘⢿⡿⣿⣴⠟⣡⣏⢸⢹⣿⣧⡄⠈⠻⣿⠟⢋⣴⠃⠀⠀⠀
⠀⠀⢀⡇⢀⣾⣅⠀⠈⠳⣿⡟⣇⢿⡻⣷⢌⠣⡟⣿⣦⡞⢉⡼⢿⣷⣌⠫⣴⣻⣿⠟⠁⣀⣿⣦⡀⠈⠙⠿⣷⣼⣿⡟⣡⠞⣫⣏⢸⣬⣴⣿⡿⢦⡀⠈⢳⣯⠷⡃⠀⠀⠀
⠀⠀⢘⡿⠛⣡⡿⢳⣄⠀⠈⢻⣿⡖⢵⣮⣿⠇⣿⡿⢋⡴⣟⡿⣦⡙⢿⣷⣼⠟⠁⣠⣾⣯⡙⢯⣿⠷⣤⣀⠀⠈⠉⠙⠛⠛⠛⠛⠛⠉⠉⠀⣀⣤⡿⢦⣄⡙⢿⡇⠀⠀⠀
⠀⠀⣾⢡⣾⡙⣶⡟⢹⣷⣄⠸⡏⠙⣶⣬⣤⡾⢋⣴⣟⣻⣌⠳⣮⣿⣶⠟⠁⣠⣾⣿⡻⣷⣽⠞⣡⣾⠟⣋⣿⣿⣶⣶⠶⠶⣶⣶⣶⣶⣾⣿⣿⣿⢹⡾⢋⡿⣆⢻⡄⠀⠀
⠀⠘⣇⢸⣽⢷⣄⠻⣿⢹⡿⣿⡇⠀⢼⠿⠶⠶⠿⠷⠶⠶⠿⠷⣾⠟⠁⣠⣾⠿⠿⠾⠷⠾⠷⠾⠿⠶⣾⠿⠷⠿⣾⣿⠀⠀⣏⣥⣤⣤⣍⠛⣿⣿⠏⣰⡟⢦⣿⢸⡇⠀⠀
⠀⠀⠻⣆⡿⢋⣩⣷⣿⢸⡇⣿⡇⠀⢾⣀⣀⣀⣀⣀⣀⣀⣤⠞⠁⣠⣾⣿⣿⠀⣀⣀⣀⣀⣀⣀⣀⡄⣿⣀⣀⠘⣿⣿⠀⠀⣿⣯⡙⣾⢻⣧⢸⣿⠀⣿⡙⢾⣥⡾⠁⠀⠀
⠀⠀⣰⠏⣰⡟⠻⣌⣿⢸⡇⣿⡇⠀⣹⣿⣿⣿⣿⣿⣿⡟⠁⢀⡴⠋⢹⣿⣿⣸⣿⣿⣿⠀⠨⣿⢻⡇⣿⣿⣿⣷⣿⣿⠀⠀⣿⣏⢹⣾⢸⣧⡾⢻⣧⠹⣟⣦⡙⢦⡀⠀⠀
⠀⠘⢃⡾⣟⣹⣦⡙⣧⢸⠇⠉⠉⠉⠉⠉⠉⠉⢉⣿⠋⠀⣴⣿⣷⠀⠈⢿⣿⡛⢿⣽⣿⠀⠰⣿⣾⣇⣿⡿⢋⣥⣿⣿⠀⠀⣿⣇⢸⢹⢸⣯⣴⢿⢛⣷⣌⢳⣿⣌⠓⠀⠀
⠀⠀⣾⣷⡙⢧⣦⡙⣿⣼⡿⢻⡟⠛⣿⣿⡿⣿⣿⠃⢀⡾⠛⠛⠻⡇⠀⠘⣿⣿⣦⣹⣿⠀⢰⡇⠻⣿⣩⡴⣯⡼⣿⣿⠀⠀⣿⡗⢸⠿⣼⡿⣿⣼⢟⢵⣼⠋⣴⢿⡄⠀⠀
⠀⠀⣿⠘⣿⣦⡙⢮⡼⢋⣴⣿⡇⠀⢺⣿⣇⣿⡏⢠⣾⣶⣶⣶⣶⣿⡄⠀⢹⣷⣿⢿⣿⠀⢈⣧⡀⠈⢿⣷⣌⡇⣿⣿⠀⠀⣿⡿⢦⣷⢸⣿⡌⢻⣴⠋⣡⣾⡇⣸⠇⠀⠀
⠀⠀⠘⣧⠙⣦⣿⠋⢠⣿⡏⣿⡇⠀⢹⣿⣿⣿⡇⣾⣿⣮⢳⡌⢳⣿⣧⠀⠀⣿⣿⠘⣿⠀⠀⣿⣷⡄⠀⠙⣿⣧⣿⣿⠀⠀⣿⡟⢸⡞⢩⣴⣿⣦⠙⣿⣥⡞⢠⡟⠀⠀⠀
⠀⠀⠀⠙⣷⡾⢃⣴⣏⠻⣷⣿⡇⠀⢿⣷⣦⣴⣤⣦⣶⣼⣶⣽⣦⡙⣿⡄⠀⠸⣿⣇⠹⣆⠀⣿⣿⣿⣄⠀⠙⢿⣿⣿⠀⠀⣿⡟⣋⣴⣿⡿⢋⣽⣷⣌⠻⣶⡟⠀⠀⠀⠀
⠀⠀⠀⢸⣿⠀⣿⢋⣥⡅⣻⣿⡇⠀⣻⣷⡶⠖⠶⣶⠶⠶⢶⠶⠾⢿⡿⢿⡀⠀⢻⣿⣄⠈⢻⣿⣟⢿⢿⣷⡄⠀⠻⣿⡀⠀⣿⣿⡿⢻⣿⠁⣿⢩⣬⢹⣇⢸⣷⠀⠀⠀⠀
⠀⠀⠀⠸⣿⡄⠻⣦⣭⣴⣿⣿⡇⠀⢽⡙⠶⢽⣯⣴⣿⣿⢦⣝⣿⣩⡶⣿⣧⡴⠏⢻⣿⣦⡀⠘⠻⣿⣟⡿⢿⣦⣀⠈⠙⠿⣍⣁⣴⣿⠟⣄⢿⣮⣭⣼⠇⣸⡟⠀⠀⠀⠀
⠀⠀⣀⣤⣝⡿⣦⣌⣙⠛⠛⠻⠷⠶⠾⠿⠷⠶⠶⠶⠶⠶⠚⢛⣋⣥⣾⠿⢛⣷⡄⠀⠻⣟⣿⣦⣄⡈⠙⠛⠿⠿⠿⠷⠶⠾⠟⠛⣉⣴⣾⠟⠛⠛⣉⣡⣾⣿⣤⣄⠀⠀⠀
⠀⠀⣿⡠⢟⡿⠛⠛⠛⡛⠛⠛⠚⠒⢛⠒⡛⢾⣷⢿⢾⡿⠿⢛⣿⠟⣡⡶⠛⣩⡿⣦⡀⢈⠻⣿⣻⠿⠿⠶⢶⣶⢶⢾⡶⠒⠛⠛⠛⠛⠛⠛⢛⡛⠛⠛⢻⣟⠆⣹⡇⠀⠀
⠀⠀⠈⠛⠋⠁⠀⠀⠈⠁⠀⠀⠰⠆⠶⠆⠰⠆⠙⢷⣅⢙⡶⠛⣡⡾⠋⠀⠺⣏⡴⢋⣿⠏⠀⣈⠙⠛⢿⣿⠋⢕⡵⠋⠀⠶⠰⠷⠀⠶⠀⠀⠈⠁⠀⠀⠀⠙⠛⠋⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠟⣴⠟⠁⠀⢰⡟⠇⢋⣴⣿⡑⠚⣳⠙⠻⠶⣤⡝⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢙⡛⠋⠀⠈⠙⣛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄]]

local function art_half(from, len)
  local out = {}
  for line in (ART .. "\n"):gmatch("([^\n]*)\n") do
    out[#out + 1] = vim.fn.strcharpart(line, from, len)
  end
  return table.concat(out, "\n")
end

local function keys(half)
  return function(self)
    local all = vim.deepcopy(self.opts.preset.keys)
    local mid = math.ceil(#all / 2)
    return half == 1 and vim.list_slice(all, 1, mid) or vim.list_slice(all, mid + 1, #all)
  end
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        width = PANE_WIDTH,
        pane_gap = PANE_GAP,
        sections = {
          { pane = 1, header = art_half(0, PANE_WIDTH), padding = 2 },
          { pane = 2, header = art_half(PANE_WIDTH, PANE_WIDTH), padding = 2 },
          { pane = 1, gap = 1, padding = 1, keys(1) },
          { pane = 2, gap = 1, padding = 1, indent = 4, keys(2) },
          { section = "startup", pane = 1, indent = CENTRE },
        },
      },
      picker = {
        sources = {
          explorer = {
            hidden = true, -- Show hidden files (dotfiles)
            ignored = true, -- Show gitignored files
          },
          files = {
            hidden = true, -- Show hidden files in file picker
            -- Note: Gitignored files intentionally excluded from fuzzy finders
            -- This is standard behavior - keeps search results focused
          },
        },
      },
    },
  },
}
