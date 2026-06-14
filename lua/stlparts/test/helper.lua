local helper = require("ntf.helper")
local plugin_name = helper.get_module_root(...)

helper.root = helper.find_plugin_root(plugin_name)

function helper.before_each() end

function helper.after_each() end

vim.opt.packpath:prepend(vim.fs.joinpath(helper.root, "spec/.shared/packages"))
require("assertlib").register(require("ntf.assert").register)

local assert = require("ntf.assert")

assert.register_eq("statusline", function(str, opts)
  return vim.api.nvim_eval_statusline(str, opts).str
end)

function helper.typed_assert(raw_assert)
  local x = require("assertlib").typed(raw_assert)
  ---@cast x +{statusline:fun(str,opts,want)}
  return x
end

return helper
