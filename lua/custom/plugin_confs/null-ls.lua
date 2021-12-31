local ok, null_ls = pcall(require, "null-ls")

if not ok then
   return
end

local b = null_ls.builtins

local sources = {

   b.code_actions.gitsigns,

   -- JS html css stuff
   b.formatting.prettierd.with {
      filetypes = { "html", "json", "yaml", "markdown", "scss", "css", "javascript", "javascriptreact" },
   },
   b.diagnostics.eslint.with {
      command = "eslint_d",
   },

   -- Lua
   b.formatting.stylua,
   --b.diagnostics.luacheck.with { extra_args = { "--globals", "vim" } },
   b.diagnostics.luacheck,

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   -- ruby
   b.formatting.rubocop,
}

local M = {}
M.setup = function(on_attach)
   null_ls.setup {
      sources = sources,
      debug = true,
      on_attach = on_attach,
   }
end

return M
