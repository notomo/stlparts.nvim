local M = {}

M.default = {}

local _state = vim.deepcopy(M.default)
function M.state()
  return _state
end

function M.set(setting)
  _state = vim.tbl_extend("force", _state, setting)
end

return M
