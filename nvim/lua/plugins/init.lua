return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- C# Support
  {
    "iabdelkareem/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Required
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim", -- Optional, but recommended for debugging
    },
    config = function()
      require("csharp").setup()
    end,
  },

  -- Additional C# tools
  {
    "jlcrochet/vim-razor",
    ft = "razor",
  },
   
  -- Rust configuration (keeping your existing setup)
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    ft = "rust",
    config = function ()
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local extension_path = mason_path .. "/packages/codelldb/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      -- If you are on Linux, replace the line above with the line below:
      -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  },

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  -- DAP Configuration
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      
      -- C# DAP configuration
      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
        args = {'--interpreter=vscode'}
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }

      -- Your existing DAP UI configuration
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    'rcarriga/nvim-dap-ui', 
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end,
  },

  -- Existing plugins (keeping your setup)
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    dependencies = {"nvim-lua/plenary.nvim"},
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local tb = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", tb.help_tags, { desc = "Telescope help" })
    end,
  },

  -- Harpoon 2
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      {
        "<leader>ha",
        function() require("harpoon"):list():add() end,
        desc = "Harpoon: Add file",
      },
      {
        "<leader>hr",
        function() require("harpoon"):list():remove() end,
        desc = "Harpoon: Remove file",
      },
      {
        "<leader>hh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon: Quick menu",
      },
      {
        "<leader>h1",
        function() require("harpoon"):list():select(1) end,
        desc = "Harpoon: To file 1",
      },
      {
        "<leader>h2",
        function() require("harpoon"):list():select(2) end,
        desc = "Harpoon: To file 2",
      },
      {
        "<leader>h3",
        function() require("harpoon"):list():select(3) end,
        desc = "Harpoon: To file 3",
      },
      {
        "<leader>h4",
        function() require("harpoon"):list():select(4) end,
        desc = "Harpoon: To file 4",
      },
    },
  },

  -- Code folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "lsp", "treesitter" }
        end,
      })
    end,
  },
}
