function printpgr(main, printerProgram, printerPGR)

    local printerInput = printerProgram
        :addTextfield()
        :setPosition(11, 1)
        :setSize(32, 8)
        :setBackground(colors.black)
        :setForeground(colors.white)

    local sendInput = printerProgram
        :addButton()
        :setText("send")
        :setPosition(11, 10)
        :setSize(32, 4)
    
    local closeProgram = printerProgram
        :addButton()
        :setText("X")
    
    if (pocket) then
        printerPGR:setPosition(2, 2)
        printerInput:setPosition(6, 1)
        sendInput:setPosition(6, 10)
        closeProgram:setPosition(1, 1)

        printerPGR:setSize(8, 5)
        printerInput:setSize(16, 8)
        sendInput:setSize(16, 4)
        closeProgram:setSize(4, 4)
    else
        printerPGR:setPosition(2, 2)
        printerInput:setPosition(11, 1)
        sendInput:setPosition(11, 10)
        closeProgram:setPosition(1, 1)

        printerPGR:setSize(8, 5)
        printerInput:setSize(32, 8)
        sendInput:setSize(32, 4)
        closeProgram:setSize(4, 4)
    end

    closeProgram:onClick(function(self, event, button, x, y)
        if (event=="mouse_click")and(button==1) then
            main:show()
            printerProgram:hide()
        end
    end)

    printerPGR:onClick(function(self, event, button, x, y)
        if (event=="mouse_click")and(button==1) then
            main:hide()
            printerProgram:show()
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

return {printpgr = printpgr}