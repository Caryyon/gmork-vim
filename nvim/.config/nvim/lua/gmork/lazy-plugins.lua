-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Core dependencies
  { "nvim-lua/plenary.nvim" },

  -- Seamless tmux/nvim pane navigation (Ctrl+hjkl)
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right" },
    },
  },
  
  -- UI and navigation
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
  },
  
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
  },
  
  { "moll/vim-bbye", cmd = { "Bdelete", "Bwipeout" } },
  
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
      "folke/tokyonight.nvim",
    },
    event = "UIEnter",
    config = function()
      -- Ensure colorscheme is loaded first
      pcall(vim.cmd, "colorscheme gmork")
    end,
  },
  
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = { "<leader>t" },
  },
  
  { "ahmedkhalf/project.nvim", event = "VeryLazy" },
  -- Note: impatient.nvim is not needed with Lazy.nvim as it has built-in caching
  -- { "lewis6991/impatient.nvim", event = "VeryLazy" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
  },

  -- Better UI for vim.ui.select and vim.ui.input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        select = {
          backend = { "telescope", "builtin" },
          telescope = {
            layout_config = {
              width = 0.5,
              height = 0.4,
            },
          },
          builtin = {
            border = "rounded",
            win_options = {
              winblend = 0,
            },
          },
        },
      })
    end,
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#000000",
        fps = 60,
        render = "compact",
        stages = "fade",
        timeout = 3000,
        top_down = true,
      })
      vim.notify = notify
    end,
  },

  -- Rainbow delimiters for nested brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterGreen",
          "RainbowDelimiterCyan",
          "RainbowDelimiterViolet",
          "RainbowDelimiterOrange",
        },
      }
    end,
  },
  
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  

  -- Sidekick for Claude Code integration
  -- {
  --   "folke/sidekick.nvim",
  --   lazy = false,
  --   config = function()
  --     require("sidekick").setup({
  --       cli = {
  --         size = 80,
  --         position = "right",
  --       },
  --     })
  --     -- Auto-open Claude Code on startup
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       pattern = "*",
  --       callback = function()
  --         vim.defer_fn(function()
  --           -- Only open if we have at least one real buffer
  --           local bufs = vim.fn.getbufinfo({buflisted = 1})
  --           if #bufs > 0 then
  --             require("sidekick.cli").toggle({ name = "claude", focus = false })
  --           end
  --         end, 200)
  --       end,
  --     })
  --   end,
  --   keys = {
  --     { "<leader>ac", function() require("sidekick.cli").toggle({ name = "claude" }) end, desc = "Toggle Claude Code" },
  --     { "<leader>ax", function() require("sidekick.cli").close() end, desc = "Close Sidekick" },
  --   },
  -- },

  -- Vim-obsession for tmux-resurrect integration
  {
    "tpope/vim-obsession",
    lazy = false,
    config = function()
      -- Auto-start tracking sessions when vim opens
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          -- Only start if not already tracking and not in a git directory
          if vim.fn.exists(":Obsession") == 2 and vim.v.this_session == "" then
            local cwd = vim.fn.getcwd()
            if not cwd:match("^/tmp") and not cwd:match("^/private/tmp") then
              vim.cmd("silent! Obsession")
            end
          end
        end,
      })
    end,
  },
  
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "mdx" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  
  -- Colorschemes
  { 
    "folke/tokyonight.nvim", 
    lazy = false,
    priority = 1000,
  },
  { 
    "lunarvim/darkplus.nvim", 
    lazy = false,
    priority = 1000,
  },
  { 
    "Mofiqul/dracula.nvim", 
    lazy = false,
    priority = 1000,
  },
  
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
    },
  },
  
  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
  },
  
  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- vtsls for TypeScript (better go-to-source-definition support)
  {
    "yioneko/nvim-vtsls",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("vtsls").config({})
    end,
  },
  
  { "RRethy/vim-illuminate", event = { "BufReadPost", "BufNewFile" } },
  { "MunifTanjim/prettier.nvim", ft = { "javascript", "typescript", "json", "css", "html" } },
  
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>f", desc = "Find Files" },
      { "<leader>g", desc = "Live Grep" },
      { "<leader>b", desc = "Buffers" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
  },
  
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = { "WorktreeList", "WorktreeCreate", "WorktreeSwitch" },
  },
  
  -- Editing enhancements
  { "windwp/nvim-autopairs", event = "InsertEnter" },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },

  -- Surround text objects (add/change/delete surrounding pairs)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Flash.nvim for better motion/jumping
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  -- Utilities
  { "mbbill/undotree", cmd = "UndotreeToggle" },

  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
  },

  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
  },

  -- Linting with nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Which-key for keybinding discovery
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = { enabled = false },
        },
        win = {
          border = "rounded",
        },
      })
      -- Register key groups
      require("which-key").add({
        { "<leader>l", group = "LSP" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>d", group = "Debug" },
        { "<leader>p", group = "Plugins" },
        { "<leader>s", group = "Session" },
        { "<leader>n", group = "Nx" },
        { "<leader>o", group = "Ollama" },
        { "<leader>x", group = "Trouble" },
        { "<leader>r", group = "Rust" },
        { "<leader>c", group = "Crates" },
      })
    end,
  },

  -- Todo-comments for highlighting TODO/FIXME/etc
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("todo-comments").setup()
    end,
    keys = {
      { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    },
  },

  -- Trouble for better diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    config = function()
      require("trouble").setup()
    end,
  },

  -- AI Integration
  -- Copilot: Set COPILOT_GITHUB_ENTERPRISE_HOST in ~/.zshrc.local for enterprise
  -- Example: export COPILOT_GITHUB_ENTERPRISE_HOST="github.mycompany.com"
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      local enterprise_host = vim.env.COPILOT_GITHUB_ENTERPRISE_HOST
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = vim.env.COPILOT_NODE_COMMAND or "node",
        github_enterprise_host = enterprise_host,
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "nomnivore/ollama.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    keys = {
      { "<leader>oo", mode = { "n", "v" }, desc = "Ollama prompt" },
      { "<leader>oG", mode = { "n", "v" }, desc = "Ollama Generate Code" },
    },
    opts = {},
    config = function(_, opts)
      require("ollama").setup(opts)
      
      -- Key mappings
      vim.keymap.set({ "n", "v" }, "<leader>oo", function()
        require("ollama").prompt()
      end, { desc = "Ollama prompt" })
      
      vim.keymap.set({ "n", "v" }, "<leader>oG", function()
        require("ollama").prompt("Generate_Code")
      end, { desc = "Ollama Generate Code" })
    end,
  },
  
  -- TidalCycles live coding
  {
    "tidalcycles/vim-tidal",
    ft = "tidal",
    config = function()
      vim.g.tidal_target = "terminal"
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- Required by nvim-dap-ui
      "ravenxrz/DAPInstall.nvim",
    },
    keys = {
      { "<leader>d", desc = "Debug" },
    },
  },

  -- Rust Development
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false, -- Plugin is already lazy
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            -- Rust-specific keymaps
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set("n", "<leader>ca", function() vim.cmd.RustLsp("codeAction") end, opts)
            vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, opts)
            vim.keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, opts)
            vim.keymap.set("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end, opts)
            vim.keymap.set("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end, opts)
            vim.keymap.set("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, opts)
            vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, opts)
            vim.keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end, opts)
            vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, opts)
          end,
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = true,
              check = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },

  -- Crates.nvim for Cargo.toml dependency management
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local crates = require("crates")
      crates.setup({
        popup = {
          border = "rounded",
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })

      -- Crates.nvim keymaps (only in Cargo.toml)
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "Cargo.toml",
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
          vim.keymap.set("n", "<leader>cr", crates.reload, opts)
          vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
          vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
          vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
          vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
          vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
          vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
          vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
          vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
          vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
          vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
        end,
      })
    end,
  },
}, {
  -- Lazy.nvim configuration
  ui = {
    border = "rounded",
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})