local printer = require("printerPGR")
local basalt = require("basalt")
local main = basalt.createFrame()

peripheral.find("modem", rednet.open)


local function split (inputstr, sep)
  if sep == nil then
     sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
     table.insert(t, str)
  end
  return t
end


local gpsList = main
    :addLabel()
    :setText("hello")
    :setPosition(8,8)

printer.printpgr(main)

local function loc()
  while (true)
  do
    local x, y, z = gps.locate()
    rednet.send(7, string.format("%q %q %q", math.floor(x), math.floor(y), math.floor(z)), "gps")

    local id, msg = rednet.receive("gps")
    local parsedMSG = split(msg, ":")
    
    gpsList:setText(parsedMSG[2])
    coroutine.yield()
  end
end

parallel.waitForAll(basalt.autoUpdate, loc)