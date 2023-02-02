-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- user commands
vim.api.nvim_create_user_command("Cwd", "echo expand('%')", {})
vim.api.nvim_create_user_command("RootPathCopy", "let @* = expand('%:p')", {})
