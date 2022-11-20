while (true)
do
    for i=0, 100, 1
    do
        if (turtle.getFuelLevel() == 0) then
            turtle.refuel(1)
        end

        if (turtle.forward(1) ~= true) then
            turtle.dig("left")
        end


    turtle.turnLeft()
    if (turtle.forward(1) ~= true) then
        turtle.dig("left")
    end
    turtle.turnLeft()


    for i=0, 100, 1
    do
        if (turtle.getFuelLevel() == 0) then
            turtle.refuel(1)
        end

        if (turtle.forward(1) ~= true) then
            turtle.dig("left")
        end
    
    turtle.turnRight()
    if (turtle.forward(1) ~= true) then
        turtle.dig("left")
    end
    turtle.turnRight()