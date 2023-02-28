--- Trancate left string by window width.
--- @param component StlpartsComponent
--- @param opts table|nil: default: {max_width = number|function(ctx) return ctx:window_width() end, ellipsis = ".."}
--- @return StlpartsFunctionComponent |StlpartsFunctionComponent|
return function(component, opts)
  component = require("stlparts.core.component").get(component)
  opts = opts or {}

  local ellipsis = opts.ellipsis or ".."
  local ellipsis_length = vim.fn.strwidth(ellipsis)

  local get_max_width = opts.max_width or function(ctx)
    return ctx:window_width()
  end
  if type(opts.max_width) == "number" then
    get_max_width = function()
      return opts.max_width
    end
  end

  return function(ctx)
    local str = component(ctx)
    local width = vim.fn.strwidth(str)
    local max_width = get_max_width(ctx)
    if max_width < width then
      return ellipsis .. vim.fn.strpart(str, width - max_width + ellipsis_length)
    end
    return str
  end
end
