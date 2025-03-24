require("git-worktree").setup()
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    -- local transform_mod = require("telescope.actions.mt").transform_mod

    -- local trouble = require("trouble")
    -- local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    -- local custom_actions = transform_mod({
    --   open_trouble_qflist = function(prompt_bufnr)
    --     trouble.toggle("quickfix")
    --   end,
    -- })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-b>"] = actions.send_selected_to_qflist + actions.open_qflist,
            -- ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            -- ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("git_worktree")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "mf", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "mo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "ms", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "mg", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "mt", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set(
      "n",
      "mh",
      ':lua require"telescope.builtin".find_files({ hidden = true })<cr>',
      { desc = "Find all files" }
    )

    keymap.set(
      "n",
      "mr",
      "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
      { desc = "Find git worktrees" }
    )
    keymap.set(
      "n",
      "mR",
      "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
      { desc = "Create git worktree" }
    )

    vim.keymap.set("n", "mb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })

    require("isak.telescope.multigrep").setup()
  end,
}
