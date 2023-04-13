local width = 10;
local height = 2;
local depth = 5;

local function mineLine()
    -- minus 2 because the turtle is also a block;
    for x = 0, depth - 2, 1 do
        if turtle.inspect() then
            turtle.dig();
        end
        turtle.forward();
    end
end

local function turnUp()
    if turtle.inspectUp() then
        turtle.digUp();
    end
    turtle.up();
    turtle.turnRight();
    turtle.turnRight();
end

local function moveNextCol()
    for y = 0, height - 1, 1 do
        turtle.down();
    end

    turtle.turnLeft();
    if turtle.inspect() then
        turtle.dig();
    end
    turtle.forward();
    turtle.turnLeft();

end

local function main()
    for x=0,width-1,1 do
        for y = 0, height - 1, 1 do
            mineLine();
            if y ~= height - 1 then
                turnUp();
            end
        end

        if (height % 2 == 1) then
            turtle.turnRight()
            turtle.turnRight()
            for d = 0, depth - 2, 1 do
                turtle.forward();
            end
        end

        if x ~= width - 1 then
            moveNextCol();
        end
    end
end

main()
