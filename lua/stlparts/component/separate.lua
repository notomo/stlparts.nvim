--- Separate each components by '%='. see |statusline|.
--- @param components StlpartsComponent[] |StlpartsComponent|
--- @return StlpartsFunctionComponent # |StlpartsFunctionComponent|
return function(components)
  components = vim.tbl_map(function(c)
    return require("stlparts.core.component").get(c)
  end, components)

  return function(ctx)
    local strs = vim.tbl_map(function(component)
      return component(ctx)
    end, components)
    return table.concat(strs, "%=")
  end
end
