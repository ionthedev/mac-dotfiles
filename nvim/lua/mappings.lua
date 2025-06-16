require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<leader>h")
unmap("n", "<leader>v")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Leader>ww", "<cmd>write<CR>", { desc = "Save file"})


-- Enhanced folding mappings (replace existing ufo mappings)
map("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })

map("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds" })

-- Additional useful fold mappings
map("n", "zr", function()
  require("ufo").openFoldsExceptKinds()
end, { desc = "Open folds except kinds" })

map("n", "zm", function()
  require("ufo").closeFoldsWith()
end, { desc = "Close folds with" })

-- Peek fold (preview without opening)
map("n", "zK", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek fold or show hover" })

-- Navigate between folds
map("n", "]z", "zj", { desc = "Next fold" })
map("n", "[z", "zk", { desc = "Previous fold" })

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- Terminals
map("n", "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Toggle horizontal terminal" })

map("n", "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Toggle vertical terminal" })

map("n", "<leader>tf", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating terminal" })

-- C# specific mappings
map("n", "<Leader>cs", "<cmd>lua require('csharp').run_project()<CR>", { desc = "Run C# project" })
map("n", "<Leader>cb", "<cmd>lua require('csharp').build_project()<CR>", { desc = "Build C# project" })
map("n", "<Leader>ct", "<cmd>lua require('csharp').run_tests()<CR>", { desc = "Run C# tests" })
map("n", "<Leader>cf", "<cmd>lua require('csharp').fix_usings()<CR>", { desc = "Fix C# usings" })
map("n", "<Leader>cr", "<cmd>lua require('csharp').reload_project()<CR>", { desc = "Reload C# project" })

-- Godot specific mappings (if using GDScript)
map("n", "<Leader>gr", "<cmd>!godot --headless --script %<CR>", { desc = "Run current GDScript file" })
