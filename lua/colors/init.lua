local M = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
M.init = function(theme)
   if not theme then
      theme = require("core.utils").load_config().ui.theme
   end

   -- set the global theme, used at various places like theme switcher, highlights
   vim.g.nvchad_theme = theme

   local present, base46 = pcall(require, "base46")

   if present then
      -- first load the base46 theme
      local opts = {
         base = "base46",
         theme = theme,
         transparency = false,
      }
      base46.load_theme(opts)
      
      -- unload to force reload
      package.loaded["colors.highlights" or false] = nil
      -- then load the highlights
      require "colors.highlights"
   end
end

-- returns a table of colors for given or current theme
M.get = function(theme)
   if not theme then
      theme = vim.g.nvchad_theme
   end

   return require("hl_themes." .. theme)
end

return M
