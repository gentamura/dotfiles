vim.keymap.set(
  "n",
  "<leader>fm",
  [[<cmd>lua require("stylua-nvim").format_file()<CR>]],
  { noremap = true, silent = true }
)
