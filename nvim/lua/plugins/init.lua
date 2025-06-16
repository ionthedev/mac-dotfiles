return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
   
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function ()
    local mason_path = vim.fn.stdpath("data") .. "/mason"
    local extension_path = mason_path .. "/packages/codelldb/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    local codelldb_path = extension_path .. "adapter/codelldb"
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

  {
    'mfussenegger/nvim-dap',
    config = function()
			local dap, dapui = require("dap"), require("dapui")
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

  -- 🧭 Telescope – fuzzy finder
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

  -- 🎯 Harpoon 2 with Telescope integration
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
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Set the provider to use LSP and fallback to treesitter
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Skip folding for certain buffer types and filetypes that cause issues
          local skip_ft = {
            "help",
            "alpha",
            "dashboard", 
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
            "NvimTree",
            "telescope",
            "TelescopePrompt",
            "TelescopeResults", 
            "dapui_watches",
            "dapui_breakpoints",
            "dapui_scopes", 
            "dapui_console",
            "dapui_stacks",
            "dap-repl",
            "terminal",
            "",
          }

          local skip_bt = {
            "terminal",
            "nofile", 
            "quickfix",
            "prompt",
            "help",
            "acwrite",
          }

          -- Check if we should skip this buffer
          if vim.tbl_contains(skip_ft, filetype) or vim.tbl_contains(skip_bt, buftype) then
            return ""
          end

          -- For normal files, use LSP as main provider and treesitter as fallback
          -- nvim-ufo only supports max 2 providers: main and fallback
          return { "lsp", "treesitter" }
        end,

        -- Add fold preview configuration  
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (" 󰁂 %d "):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,

        -- Close all folds on buffer enter to avoid issues
        close_fold_kinds_for_ft = {
          default = { "imports", "comment" },
          json = { "array" },
          c = { "comment", "region" },
        },
      })
    end,
  },
}
