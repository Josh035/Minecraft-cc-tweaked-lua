local width = 10;
local height = 2;
local depth = 5;

local function inspect()
    return (math.random() > 0.5);
end

local function inspectUp()
    return (math.random() > 0.5);
end

local function dig()
    print("mined block");
end

local function digUp()
    print("mined up");
end

local function forward()
    print("went forward");
end

local function up()
    print("moved Up");
end

local function down()
    print("moved down");
end

local function turnRight()
    print("turned Right");
end

local function turnLeft()
    print("turned Left");
end

local function mineLine()
    -- minus 2 because the turtle is also a block;
    for x = 0, depth - 2, 1 do
        if inspect() then
            dig();
        end
        forward();
    end
end

local function turnUp()
    if inspectUp() then
        digUp();
    end
    up();
    turnRight();
    turnRight();
end

local function moveNextCol()
    print("-------------");

    for y = 0, height - 1, 1 do
        down();
    end

    turnRight();
    if inspect() then
        dig();
    end
    forward();
    turnLeft();

end

local function main()
    for x=0,width-1,1 do
        for y = 0, height - 1, 1 do
            mineLine();
            turnUp();
            if y < height -1 and (height % 2 == 0) then
                print("-------");
            end
        end

        if (height % 2 == 1) then
            print("moving back to Start");
            turnRight()
            turnRight()
            for d = 0, depth - 1, 1 do
                forward();
            end
        end

        moveNextCol();
    end
end

main()
