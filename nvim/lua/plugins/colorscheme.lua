return {

  { "catppuccin/nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("catppuccin").load("frappe")
        require("catppuccin.groups.integrations.bufferline").get_theme()
      end,
    },
  },
}
