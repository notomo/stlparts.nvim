local vim = vim
local fn = vim.fn

--- Truncate right string by window width.
--- @param component StlpartsComponent Limitation: separate, highlight component does not work under truncate_right component.
--- @return StlpartsFunctionComponent # |StlpartsFunctionComponent|
return function(component, opts)
  component = require("stlparts.core.component").get(component)
  opts = opts or {}

  local ellipsis = opts.ellipsis or ".."
  local ellipsis_length = fn.strwidth(ellipsis)

  local get_max_width = opts.max_width or function(ctx)
    return ctx:width()
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
      result = fn.strpart(evaled_str, 0, math.floor(max_width - ellipsis_length)) .. ellipsis
    end

    result = result:gsub("%%", "%%%%")
    return result
  end
end
