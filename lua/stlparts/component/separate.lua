--- Separate each components by '%='. see |statusline|.
--- @param components StlpartsComponent[] |StlpartsComponent|
--- @return StlpartsFunctionComponent # |StlpartsFunctionComponent|
return function(components)
  components = vim
    .iter(components)
    :map(function(c)
      return require("stlparts.core.component").get(c)
    end)
    :totable()

  return function(ctx)
    local strs = vim
      .iter(components)
      :map(function(component)
        return component(ctx)
      end)
      :totable()
    return table.concat(strs, "%=")
  end
end
