local helper = require("stlparts.test.helper")
local stlparts = helper.require("stlparts")

describe("stlparts.build()", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("returns statusline string", function()
    vim.cmd.edit("test")

    local Padding = stlparts.component("padding")
    local Separate = stlparts.component("separate")

    stlparts.set(
      "default",
      Padding(Separate(function()
        return vim.fn.expand("%")
      end, {
        function()
          return "st"
        end,
        "r",
      }))
    )

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, " test   str ")
  end)
end)
