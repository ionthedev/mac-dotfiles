require("nvchad.configs.lspconfig").defaults()

local servers = { 
  "html", 
  "cssls",
  "omnisharp", -- C# language server
  "gdscript", -- Godot GDScript language server (if using GDScript)
}

-- Enable the language servers
vim.lsp.enable(servers)

-- Custom configuration for OmniSharp (C#)
require("lspconfig").omnisharp.setup({
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = false,
  organize_imports_on_format = false,
  enable_import_completion = false,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
})

-- Godot LSP configuration
require("lspconfig").gdscript.setup({
  cmd = { "nc", "localhost", "6005" }, -- Default Godot LSP port
})
