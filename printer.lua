--local basalt = require("basalt")

--local main = basalt.createFrame()

local printer = {}

function printer.pgr(main)

    local printerPGR = main
        :addButton()
        :setText("printer")
        :setPosition(2, 2)
        :setSize(8, 5)

    local printerInput = main
        :addTextfield()
        :setPosition(11, 1)
        :setSize(32, 8)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :hide()

    local sendInput = main
        :addButton()
        :setText("send")
        :setPosition(11, 10)
        :setSize(32, 4)
        :hide()


    printerPGR:onClick(function(self, event, button, x, y)
        if (event=="mouse_click")and(button==1) then
            printerInput:show()
            sendInput:show()
            printerPGR:hide()
        end
    end)

    sendInput:onClick(function(self, event, button, x, y)
        if (event=="mouse_click")and(button==1) then
            local printer = peripheral.find("printer")
            local page = printer.newPage()

            if page then
                printer.write(table.concat(printerInput:getLines(), " "))
                printer.endPage()
            end
        end
    end)
end

--basalt.autoUpdate()