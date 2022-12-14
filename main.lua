local printer = require("printerPGR")
local gpsservice = require("gpsSRVC")
local basalt = require("basalt")


local main = basalt.createFrame()
local gpsService = basalt.createFrame()
  :hide()

local printerProgram = basalt.createFrame()
  :hide()

peripheral.find("modem", rednet.open)

local printerPGR = main
  :addButton()
  :setText("printer")
  :setPosition(2, 2)
  :setSize(8, 5)


printer.printpgr(main, printerProgram, printerPGR)


-- GPS service
local gpsPGR = main
  :addButton()
  :setText("GPS")
  :setSize(8, 5)

local gpsList = gpsService
  :addList()

local closeProgram = gpsService
  :addButton()
  :setText("X")

if (pocket) then
  gpsPGR:setPosition(2, 8)
  gpsList:setPosition(3, 1)
  closeProgram:setPosition(1, 18)

  gpsList:setSize(22, 19)
  closeProgram:setSize(26, 3)
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