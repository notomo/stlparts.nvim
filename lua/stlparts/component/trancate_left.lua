local vim = vim
local fn = vim.fn

--- Trancate left string by window width.
--- @param component StlpartsComponent Limitation: separate component does not work under truncate_left component.
--- @param opts table|nil: default: {max_width = number|function(ctx) return ctx:window_width() end, ellipsis = ".."}
--- @return StlpartsFunctionComponent |StlpartsFunctionComponent|
return function(component, opts)
  component = require("stlparts.core.component").get(component)
  opts = opts or {}

  local ellipsis = opts.ellipsis or ".."
  local ellipsis_length = fn.strwidth(ellipsis)

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
    local evaled = vim.api.nvim_eval_statusline(str, {
      winid = ctx.window_id,
    })
    local evaled_str = evaled.str

    local result = evaled_str
    local max_width = get_max_width(ctx)
    local width = evaled.width
    if max_width < width then
      result = ellipsis .. fn.strpart(evaled_str, width - max_width + ellipsis_length)
    end

    result = result:gsub("%%", "%%%%")
    return result
  end
end
