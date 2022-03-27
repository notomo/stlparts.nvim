local plugin_name = vim.split((...):gsub("%.", "/"), "/", true)[1]
local M = require("vusted.helper")

M.root = M.find_plugin_root(plugin_name)

function M.before_each() end

function M.after_each()
  vim.cmd("silent %bwipeout!")
  M.cleanup_loaded_modules(plugin_name)
  print(" ")
end

local asserts = require("vusted.assert").asserts

asserts.create("statusline"):register_eq(function(str, opts)
  return vim.api.nvim_eval_statusline(str, opts).str
end)

return M
