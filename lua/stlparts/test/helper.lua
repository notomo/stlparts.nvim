local helper = require("vusted.helper")
local plugin_name = helper.get_module_root(...)

helper.root = helper.find_plugin_root(plugin_name)

function helper.before_each() end

function helper.after_each()
  helper.cleanup()
  helper.cleanup_loaded_modules(plugin_name)
end

vim.opt.packpath:prepend(vim.fs.joinpath(helper.root, "spec/.shared/packages"))
require("assertlib").register(require("vusted.assert").register)

local asserts = require("vusted.assert").asserts

asserts.create("statusline"):register_eq(function(str, opts)
  return vim.api.nvim_eval_statusline(str, opts).str
end)

function helper.typed_assert(assert)
  local x = require("assertlib").typed(assert)
  ---@cast x +{statusline:fun(str,opts,want)}
  return x
end

return helper
