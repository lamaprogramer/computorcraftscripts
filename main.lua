local printer = require("printerPGR")
local gpsservice = require("gpsSRVC")
local basalt = require("basalt")


local main = basalt.createFrame()
local gpsService = basalt.createFrame()
  :hide()

peripheral.find("modem", rednet.open)

local printerPGR = main
  :addButton()
  :setText("printer")
  :setPosition(2, 2)
  :setSize(8, 5)


printer.printpgr(main, printerPGR)


-- GPS service
local gpsPGR = gpsService
  :addButton()
  :setText("GPS")
  :setSize(8, 5)

local gpsList = gpsService
  :addList()
  :hide()

local closeProgram = gpsService
  :addButton()
  :setText("X")
  :hide()

if (pocket) then
  gpsPGR:setPosition(2, 8)
  gpsList:setPosition(6, 1)
  closeProgram:setPosition(1, 1)

  gpsList:setSize(16, 19)
  closeProgram:setSize(4, 4)
else
  gpsPGR:setPosition(2, 8)
  gpsList:setPosition(11, 1)
  closeProgram:setPosition(1, 1)

  gpsList:setSize(32, 18)
  closeProgram:setSize(4, 4)
end


gpsPGR:onClick(function(self, event, button, x, y)
  if (event=="mouse_click")and(button==1) then
    gpsService:show()
    main:hide()
  end
end)

closeProgram:onClick(function(self, event, button, x, y)
  if (event=="mouse_click")and(button==1) then
    gpsService:hide()
    main:show()
  end
end)


local locations = {}

parallel.waitForAll(basalt.autoUpdate, function ()
  gpsservice.gpssrvc(locations, gpsList)
end)