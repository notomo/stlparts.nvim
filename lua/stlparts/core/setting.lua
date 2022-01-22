local M = {}

M.default = {
  root = function()
    return ""
  end,
}

local _state = vim.deepcopy(M.default)
function M.state()
  return _state
end

function M.set(setting)
  _state = vim.tbl_deep_extend("force", M.default, setting)
end

return M
