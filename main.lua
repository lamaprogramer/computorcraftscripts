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

printer.printpgr(main)


-- GPS service
local gpsPGR = main
  :addButton()
  :setText("GPS")
  :setSize(8, 5)

local gpsList = main
  :addList()
  :hide()

local closeProgram = main
  :addButton()
  :setText("X")
  :hide()

if (pocket) then
  gpsPGR:setPosition(8, 12)
  gpsList:setPosition(6, 1)
  closeProgram:setPosition(1, 1)

  gpsList:setSize(16, 19)
  closeProgram:setSize(4, 4)
else
  gpsPGR:setPosition(8, 12)
  gpsList:setPosition(11, 1)
  closeProgram:setPosition(1, 1)

  gpsList:setSize(32, 18)
  closeProgram:setSize(4, 4)
end


gpsPGR:onClick(function(self, event, button, x, y)
  if (event=="mouse_click")and(button==1) then
    gpsPGR:hide()
    gpsList:show()
    closeProgram:show()
  end
end)

closeProgram:onClick(function(self, event, button, x, y)
  if (event=="mouse_click")and(button==1) then
    gpsPGR:show()
    gpsList:hide()
    closeProgram:hide()
  end
end)


local locations = {}
local function loc()
  while (true)
  do
    local x, y, z = gps.locate()
    if (x and y and z) then
      rednet.send(7, string.format("%q %q %q", math.floor(x), math.floor(y), math.floor(z)), "gps")

      local id, msg = rednet.receive("gps")
      local parsedMSG = split(msg, ":")
      
      local senderID = parsedMSG[1]
      local senderPOS = parsedMSG[2]
      locations[senderID] = senderPOS

      gpsList:clear()
      for si, pos in pairs(locations)
      do
        gpsList:addItem(si .. ": " .. pos)
      end
     
      coroutine.yield()
    else
      coroutine.yield()
    end
  end
end

parallel.waitForAll(basalt.autoUpdate, function ()
  loc()
end)