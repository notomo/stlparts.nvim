local fn = vim.fn

local M = {}

--- @param str string
--- @return string[] # the characters of str, each whole however many bytes it takes
local function characters(str)
  return fn.split(str, "\\zs")
end

--- @param str string
--- @param max_width integer
--- @return string # the longest run of characters at the start of str that is at most max_width cells wide
local function head(str, max_width)
  local chars = characters(str)
  local to = 0
  local width = 0
  for i = 1, #chars do
    width = width + fn.strwidth(chars[i])
    if width > max_width then
      break
    end
    to = i
  end
  return table.concat(chars, "", 1, to)
end

--- @param str string
--- @param max_width integer
--- @return string # the longest run of characters at the end of str that is at most max_width cells wide
local function tail(str, max_width)
  local chars = characters(str)
  local from = #chars + 1
  local width = 0
  for i = #chars, 1, -1 do
    width = width + fn.strwidth(chars[i])
    if width > max_width then
      break
    end
    from = i
  end
  return table.concat(chars, "", from, #chars)
end

--- @param str string the string as it is displayed, holding no statusline item any more
--- @param max_width integer the cells the result has to fit in
--- @param ellipsis string what stands in for the cut away part
--- @return string # str with its start cut away to fit, the ellipsis in place of what went
function M.left(str, max_width, ellipsis)
  local ellipsis_width = fn.strwidth(ellipsis)
  if max_width < ellipsis_width then
    return head(ellipsis, max_width)
  end
  return ellipsis .. tail(str, max_width - ellipsis_width)
end

--- @param str string the string as it is displayed, holding no statusline item any more
--- @param max_width integer the cells the result has to fit in
--- @param ellipsis string what stands in for the cut away part
--- @return string # str with its end cut away to fit, the ellipsis in place of what went
function M.right(str, max_width, ellipsis)
  local ellipsis_width = fn.strwidth(ellipsis)
  if max_width < ellipsis_width then
    return tail(ellipsis, max_width)
  end
  return head(str, max_width - ellipsis_width) .. ellipsis
end

return M
