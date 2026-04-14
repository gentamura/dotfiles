--[[ Neovim option ]]
vim.opt.encoding = "UTF-8"
vim.opt.helplang = "en"
vim.opt.ruler = true
vim.opt.number = true
vim.opt.history = 2000

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.list = true
vim.opt.listchars.tab = "> "
vim.opt.formatoptions:append("mM")
vim.opt.clipboard:append("unnamedplus")

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.mouse = "nv"

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

--[[ Keymap ]]
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy full path" })
vim.keymap.set("n", "<leader>cr", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative path" })

--[[ Netrw ]]
vim.g.netrw_localmovecmd = "mv"

--[[ Plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "svrana/neosolarized.nvim",
    dependencies = { "tjdevries/colorbuddy.vim" },
    config = function()
      local neosolarized = require("neosolarized")
      neosolarized.setup({
        comment_italics = true,
      })
      if type(neosolarized.set_colors) == "function" then
        vim.cmd("colorscheme neosolarized")
      end

      local cb = require("colorbuddy.init")
      local Color = cb.Color
      local colors = cb.colors
      local Group = cb.Group
      local groups = cb.groups
      local styles = cb.styles

      Color.new("black", "#000000")
      Group.new("CursorLine", colors.none, colors.base03, styles.NONE, colors.base1)
      Group.new("CursorLineNr", colors.yellow, colors.black, styles.NONE, colors.base1)
      Group.new("Visual", colors.none, colors.base03, styles.reverse)

      local cError = (groups.Error and groups.Error.fg) or colors.red
      local cInfo = (groups.Information and groups.Information.fg) or colors.blue
      local cWarn = (groups.Warning and groups.Warning.fg) or colors.yellow
      local cHint = (groups.Hint and groups.Hint.fg) or colors.cyan

      Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
      Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
      Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
      Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")

      lualine.setup({
        options = {
          icons_enabled = true,
          theme = "solarized_dark",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            "encoding",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "fugitive" },
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        color_icons = true,
        default = true,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end
      configs.setup({
        ensure_installed = {
          "astro",
          "bash",
          "comment",
          "css",
          "go",
          "gomod",
          "gosum",
          "graphql",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "prisma",
          "proto",
          "python",
          "regex",
          "ruby",
          "rust",
          "scss",
          "solidity",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "yaml",
        },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(_, bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end

            vim.schedule(function()
              gs.next_hunk()
            end)

            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end

            vim.schedule(function()
              gs.prev_hunk()
            end)

            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>hd", gs.diffthis)
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end)
          map("n", "<leader>td", gs.toggle_deleted)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup({
        hook = function()
          local line_number = vim.api.nvim_win_get_cursor(0)[1] - 1
          local current_line = vim.api.nvim_buf_get_lines(0, line_number, line_number + 1, false)[1]
          local filetype = vim.api.nvim_buf_get_option(0, "filetype")

          if
            filetype == "javascript"
            or filetype == "typescript"
            or filetype == "javascriptreact"
            or filetype == "typescriptreact"
          then
            if string.match(current_line, "^%s*<") or string.match(current_line, "^%s*</") then
              vim.api.nvim_buf_set_option(0, "commentstring", "{/*%s*/}")
            elseif string.match(current_line, "^%s*{/%*") then
              vim.api.nvim_buf_set_option(0, "commentstring", "{/*%s*/}")
            else
              vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
            end
          end
        end,
      })
    end,
  },
  {
    "ckipp01/stylua-nvim",
    config = function()
      require("stylua-nvim").setup()
      vim.api.nvim_command("autocmd BufWritePre *.lua lua require('stylua-nvim').format_file()")
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          css = { "prettier" },
          graphql = { "prettier" },
          html = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          json = { "prettier" },
          less = { "prettier" },
          markdown = { "prettier" },
          scss = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          yaml = { "prettier" },
        },
        formatters = {
          prettier = {
            prepend_args = { "--print-width", "120", "--semi", "--single-quote" },
          },
        },
      })

      vim.keymap.set("n", "<Leader>f", function()
        conform.format({ async = true })
      end, { desc = "[conform] format" })

      vim.keymap.set("x", "<Leader>f", function()
        conform.format({ async = true })
      end, { desc = "[conform] format" })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          conform.format({ bufnr = args.buf, timeout_ms = 2000 })
        end,
        desc = "[conform] format on save",
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fa", function()
        builtin.find_files({ no_ignore = true })
      end, { desc = "Find all files (including gitignored)" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fG", function()
        local dir = vim.fn.input("Dir: ", "", "dir")
        if dir ~= "" then
          builtin.live_grep({ search_dirs = { dir } })
        end
      end, { desc = "Live grep in directory" })
      vim.keymap.set("n", "<leader>fA", function()
        local dir = vim.fn.input("Dir (all): ", "", "dir")
        if dir ~= "" then
          builtin.live_grep({
            search_dirs = { dir },
            additional_args = { "--hidden", "--no-ignore", "--glob=!.git/" },
          })
        end
      end, { desc = "Live grep in directory (include hidden/ignored)" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

      local actions_state = require("telescope.actions.state")
      local copy_relative_path = function()
        local entry = actions_state.get_selected_entry()
        if not entry or not entry.path then
          return
        end
        local relative = vim.fn.fnamemodify(entry.path, ":.")
        vim.fn.setreg("+", relative)
      end
      local copy_full_path = function()
        local entry = actions_state.get_selected_entry()
        if not entry or not entry.path then
          return
        end
        vim.fn.setreg("+", entry.path)
      end

      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { ".git/", ".yarn/", "node_modules/" },
          mappings = {
            i = {
              ["<C-y>"] = copy_relative_path,
              ["<M-y>"] = copy_full_path,
              ["<esc>"] = actions.close,
            },
            n = {
              ["<C-y>"] = copy_relative_path,
              ["<M-y>"] = copy_full_path,
              ["<esc>"] = actions.close,
            },
          },
          preview = {
            treesitter = false,
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
      vim.keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<CR>")
    end,
  },
  {
    "Allianaab2m/telescope-kensaku.nvim",
    dependencies = {
      "vim-denops/denops.vim",
      "lambdalisue/vim-kensaku",
    },
    config = function()
      require("telescope").load_extension("kensaku")
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    commit = "a958783bc9d86217a4200845cd950314857636f3",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("lspsaga").setup({})
      local keymap = vim.keymap.set

      -- https://dev.neovim.pro/lspsaga/finder/
      keymap("n", "gh", "<cmd>Lspsaga finder<CR>")

      -- https://dev.neovim.pro/lspsaga/codeaction/
      keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

      -- https://dev.neovim.pro/lspsaga/rename/
      keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

      -- https://dev.neovim.pro/lspsaga/definition/
      keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

      -- https://dev.neovim.pro/lspsaga/diagnostic/
      keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      keymap("n", "[E", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end)
      keymap("n", "]E", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end)

      -- https://dev.neovim.pro/lspsaga/outline/
      keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

      -- https://dev.neovim.pro/lspsaga/hover/
      keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

      -- https://dev.neovim.pro/lspsaga/callhierarchy/
      keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
      keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

      -- https://dev.neovim.pro/lspsaga/floaterm/
      keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      vim.lsp.config("eslint", { capabilities = capabilities })
      vim.lsp.config("cssls", { capabilities = capabilities })
      vim.lsp.config("cssmodules_ls", { capabilities = capabilities })
      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
        -- https://cva.style/docs/installation#intellisense
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      })

      local function enable_if_available(name, cmd)
        if vim.fn.executable(cmd) == 1 then
          vim.lsp.enable(name)
        end
      end

      enable_if_available("lua_ls", "lua-language-server")
      enable_if_available("eslint", "vscode-eslint-language-server")
      enable_if_available("cssls", "vscode-css-language-server")
      enable_if_available("cssmodules_ls", "cssmodules-language-server")
      enable_if_available("tailwindcss", "tailwindcss-language-server")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({})
    end,
  },
  {
    "dart-lang/dart-vim-plugin",
    ft = { "dart" },
    init = function()
      vim.g.dart_style_guide = 2
      vim.g.dart_format_on_save = 1
    end,
  },
}, {
  defaults = {
    lazy = false,
  },
})
