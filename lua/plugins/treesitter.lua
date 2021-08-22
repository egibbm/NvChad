local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

ts_config.setup {
   ensure_installed = {
      "lua",
      -- additionals
      "javascript",
      "html",
      "css",
      "json",
      "ruby",
      "yaml",
      "python"
      -- "rust",
      -- "go"
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
}
