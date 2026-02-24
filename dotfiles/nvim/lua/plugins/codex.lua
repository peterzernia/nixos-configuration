---@type LazySpec[]
return {
  {
    "johnseth97/codex.nvim",
    lazy = true,
    cmd = { "Codex", "CodexToggle" },
    keys = {
      {
        "<leader>cc",
        function() require("codex").toggle() end,
        desc = "Toggle Codex",
      },
    },
    opts = {
      keymaps = {
        toggle = "<leader>cc",
        quit = "<C-q>",
      },
      border = "rounded",
      width = 0.8,
      height = 0.8,
      autoinstall = false,
      panel = false,             -- floating popup (true = side panel)
      use_buffer = false,        -- run in terminal buffer
    },
  },
}
