local helper = require("stlparts.test.helper")
local stlparts = helper.require("stlparts")

describe("file_type component", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("can build with specified filetype", function()
    vim.cmd([[edit test]])
    vim.bo.filetype = "lua"

    stlparts.set(
      "default",
      stlparts.component("file_type")({
        lua = function()
          return "ok"
        end,
      }, function()
        return "ng"
      end)
    )

    local str = stlparts.build("default")
    assert.statusline(str, {}, "ok")
  end)

  it("can build with non-specified filetype", function()
    stlparts.set(
      "default",
      stlparts.component("file_type")({
        lua = function()
          return "ng"
        end,
      }, function()
        return "ok"
      end)
    )

    local str = stlparts.build("default")
    assert.statusline(str, {}, "ok")
  end)
end)
