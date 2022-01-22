local M = {}
M.__index = M

function M.new(msg)
  local tbl = { _msg = msg }
  return setmetatable(tbl, M)
end

function M.build(self)
  return ("error(%s)"):format(self._msg)
end

return M
