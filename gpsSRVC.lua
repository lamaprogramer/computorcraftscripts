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

local function gpssrvc(locations, gpsList)
    while (true)
    do
        local x, y, z = gps.locate(1)
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

return {gpssrvc = gpssrvc}