local vim = vim
local truncate = require("stlparts.core.truncate")

--- Truncate left string by window width.
--- @param component StlpartsComponent Limitation: separate, highlight component does not work under truncate_left component.
--- @param opts StlpartsTruncateLeftOption?
--- @return StlpartsFunctionComponent # |StlpartsFunctionComponent|
return function(component, opts)
  component = require("stlparts.core.component").get(component)
  opts = opts or {}

  local ellipsis = opts.ellipsis or ".."

  local get_max_width = opts.max_width or function(ctx)
    return ctx:width()
  end
  local fixed_max_width = opts.max_width
  if type(fixed_max_width) == "number" then
    get_max_width = function()
      return fixed_max_width
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
    if max_width < evaled.width then
      result = truncate.left(evaled_str, max_width, ellipsis)
    end

    result = result:gsub("%%", "%%%%")
    return result
  end
end

--- @class StlpartsTruncateLeftOption
--- @field max_width (number|fun(ctx:StlpartsContext):number)? default: window width
--- @field ellipsis string? default: ".."
