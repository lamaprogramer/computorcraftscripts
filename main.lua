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
    :addList()
    :setPosition(8,8)

printer.printpgr(main)
local locations = {}

local function loc()
  while (true)
  do
    local x, y, z = gps.locate()
    rednet.send(7, string.format("%q %q %q", math.floor(x), math.floor(y), math.floor(z)), "gps")

    local id, msg = rednet.receive("gps")
    local parsedMSG = split(msg, ":")
    
    local senderID = parsedMSG[1]
    local senderPOS = parsedMSG[2]

    locations[senderID] = senderPOS

    --local posList = ""
    gpsList:clear()
    for si, pos in pairs(locations)
    do
      --posList = poslist .. si .. ": " .. pos .. "\n"
      gpsList:addItem(si .. ": " .. pos)
    end
    gpsList:setText(posList)
    coroutine.yield()
  end
end

parallel.waitForAll(basalt.autoUpdate, loc)