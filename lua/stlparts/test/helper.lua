local plugin_name = vim.split((...):gsub("%.", "/"), "/", true)[1]
local helper = require("vusted.helper")

helper.root = helper.find_plugin_root(plugin_name)

function helper.before_each() end

function helper.after_each()
  helper.cleanup()
  helper.cleanup_loaded_modules(plugin_name)
  print(" ")
end

local asserts = require("vusted.assert").asserts

asserts.create("statusline"):register_eq(function(str, opts)
  return vim.api.nvim_eval_statusline(str, opts).str
end)

return helper
