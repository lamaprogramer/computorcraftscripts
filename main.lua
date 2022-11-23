local basalt = require("basalt")
local main = basalt.createFrame()

local label = main
    :addLabel()
    :setText("hello")
    :setPosition(8,8)

printer.printpgr(main)

local function loc()
  while (true)
  do
    local x, y, z = gps.locate()
    rednet.send(7, string.format("%q %q %q", x, y, z), "gps")

    local id, msg = rednet.receive("gps")
    label:setText(msg)
    coroutine.yield()
  end
end

parallel.waitForAll(basalt.autoUpdate, loc)