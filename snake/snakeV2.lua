-- "ENUMS"

UP = "up"
DOWN = "down"
LEFT = "left"
RIGHT = "right"

-- /"ENUMS"
-- globals
local gPlayer = {0};
local gFruit = 10

local sWidth = 51;
local sHeight = 18;

local dirInputBuffer = {RIGHT};
local dirBufferMax = 3

local tickDelay = 0.02;
local frameDelay = 0.5;

-- /globals

-- prints to monitor
local function printDebug(debug)
    local monitor = peripheral.wrap("top");

    if monitor ~= nil then
        monitor.write(debug);
    end
end

-- resets monitor
local function resetDebug()
    local monitor = peripheral.wrap("top");
    if monitor ~= nil then
        monitor.clear();
        monitor.setCursorPos(1, 1);
    end
end

local function getBoardCoords(player)
    local returnTable = {1, 1};
    if player < sWidth then
        returnTable[1] = player;
    else
        returnTable[2] = math.floor(player / sWidth);
        returnTable[1] = player - returnTable[2] * sWidth;
        returnTable[2] = returnTable[2] + 1;
    end

    returnTable[1] = returnTable[1] + 1;

    return returnTable;
end

local function checkFruitAvailable(fruitPos)
    for p in ipairs(gPlayer) do
        if fruitPos == gPlayer[p] then
            return false;
        end
    end

    return true;
end

-- moves the head of the player (snake), depending of the input provided by the user
local function moveHead(char)
    -- maps the input char to the corresponding movement of the player head
    -- NOTE: of course lua doesn't have a switch case statement, why would it?
    if (char):lower() == "d" then
        gPlayer[1] = gPlayer[1]+ 1;
    elseif (char):lower() == "a" then
        gPlayer[1] = gPlayer[1] - 1;
    elseif (char):lower() == "s" then
        gPlayer[1] = gPlayer[1] + sWidth;
    elseif (char):lower() == "w" then
        gPlayer[1] = gPlayer[1] - sWidth;
    end

    if gPlayer[1] == gFruit then

        gFruit = math.random(1, sWidth*sHeight)

        -- lua doesn't have the FUCKING not operator(!)
        while (false == checkFruitAvailable(gFruit)) do
            gFruit = gFruit + 1;
            if gFruit > sWidth * sHeight then
                -- Fruit is set to one, because lua fucking starts every array at index 1
                gFruit = 1;
            end
        end

        gPlayer[#gPlayer + 1] = gPlayer[#gPlayer];
    end
end

local function validateFruit()
    if gPlayer[1] == gFruit then

        gFruit = math.random(1, sWidth*sHeight)

        -- lua doesn't have the FUCKING not operator(!)
        while (false == checkFruitAvailable(gFruit)) do
            gFruit = math.random(1, sWidth * sHeight);
        end

        gPlayer[#gPlayer + 1] = gPlayer[#gPlayer];
    end
end

local function moveHeadDirection(dir)
    if (dir):lower() == RIGHT then
        gPlayer[1] = gPlayer[1]+ 1;
    elseif (dir):lower() == LEFT then
        gPlayer[1] = gPlayer[1] - 1;
    elseif (dir):lower() == DOWN then
        gPlayer[1] = gPlayer[1] + sWidth;
    elseif (dir):lower() == UP then
        gPlayer[1] = gPlayer[1] - sWidth;
    end

    if gPlayer[1] > sWidth * sHeight then
        gPlayer[1] = gPlayer[1] - sWidth * sHeight;
    elseif gPlayer[1] < 1 then
        gPlayer[1] = gPlayer[1] + sWidth * sHeight;
    end

    validateFruit();
end

-- cycles the body of the snake by inserting the previous body piece to the current
local function cyclePlayers(player, prevPlayer)
    player=prevPlayer;
end

-- draws the Player Pixels
local function drawPlayer(player, debug)
    local pPos = getBoardCoords(player);
    paintutils.drawPixel(pPos[1], pPos[2], colors.yellow);
end

-- handles the main draw event
local function draw()
    paintutils.drawBox(0, 0, 52, 19, colors.white);
    paintutils.drawFilledBox(1, 1, sWidth, sHeight, colors.black);

    local fPos = getBoardCoords(gFruit);

    for p in ipairs(gPlayer) do
        drawPlayer(gPlayer[p]);
    end
    paintutils.drawPixel(fPos[1], fPos[2], colors.orange);
end

local function handleInput()
    local event, char = os.pullEvent("char");
    local cInput = (char):lower();

    if #dirInputBuffer <= dirBufferMax then

        -- again, a switch statement would be really FUCKING useful here.
        -- enums would be nice too i guess
        if cInput == "w" then
            dirInputBuffer[#dirInputBuffer + 1] = UP;
        elseif cInput == "d" then
            dirInputBuffer[#dirInputBuffer + 1] = RIGHT;
        elseif cInput == "s" then
            dirInputBuffer[#dirInputBuffer + 1] = DOWN;
        elseif cInput == "a" then
            dirInputBuffer[#dirInputBuffer + 1] = LEFT;
        end

    end
end

-- main function
local function logic()
    --local event, char = os.pullEvent("char");

    local playerBuffer = gPlayer[1];
    local currentBuffer;

    --moveHead(char);

    moveHeadDirection(dirInputBuffer[1])

    if #dirInputBuffer > 1 then
        table.remove(dirInputBuffer, 1);
    end

    for p in ipairs(gPlayer) do
        if p > 1 then
            currentBuffer = gPlayer[p];
            gPlayer[p] = playerBuffer;
            playerBuffer = currentBuffer;
        end
    end

    --draw();
    os.sleep(tickDelay);
end

local function drawLoop()
    while true do
        draw();
        os.sleep(frameDelay);
    end
end

local function logicLoop()
    while true do 
        logic();
    end
end

local function inputLoop()
    while true do
        handleInput();
    end
end

local function main()
    -- NOTE: how the fuck, is this actually working?
    parallel.waitForAll(function() logicLoop() end, function() inputLoop() end, function() drawLoop() end);
end

main();
