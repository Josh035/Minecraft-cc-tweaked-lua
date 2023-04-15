local Player = {1, 2};
local Fruit = 10
-- screen: y=18, x=51

local sWidth = 51;
local sHeight = 18;

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
    if player < sWidth + 1 then
        returnTable[1] = player;
    else
        returnTable[2] = math.floor(player / sWidth);
        returnTable[1] = player - returnTable[2] * sWidth;
        returnTable[2] = returnTable[2] + 1;
    end

    return returnTable;
end

-- moves the head of the player (snake), depending of the input provided by the user
local function moveHead(char)
    -- maps the input char to the corresponding movement of the player head
    -- NOTE: of course lua doesn't have a switch case statement, why would it?
    if (char):lower() == "d" then
        Player[1] = Player[1]+ 1;
    elseif (char):lower() == "a" then
        Player[1] = Player[1] - 1;
    elseif (char):lower() == "s" then
        Player[1] = Player[1] + sWidth;
    elseif (char):lower() == "w" then
        Player[1] = Player[1] - sWidth;
    end

    -- TODO add validation for edges
    -- makes the player wrap around the screen
    --if player[1] > sWidth then
        --player[1] = 1;
    --end
--
    --if player[1] < 1 then
        --player[1] = sWidth;
    --end
--
    --if player[2] > sHeight then
        --player[2] = 1;
    --end
--
    --if player[2] < 1 then
        --player[2] = sHeight
    --end

    -- collision check and action for collecting food
    -- TODO: add validation, so that food doesn't spawn inside the player
    -- Idea for food validation: add numbers to coord, while the food is on the snake
    
    if Player[1] == Fruit then

        Fruit = math.random(1, sWidth*sHeight)

        Player[#Player + 1] = Player[#Player];
    end
end

local function cyclePlayers(player, prevPlayer)
    player=prevPlayer;
end

local function drawPlayer(player, debug)
    local pPos = getBoardCoords(player);
    paintutils.drawPixel(pPos[1], pPos[2], colors.yellow);
end

local function draw()
    paintutils.drawBox(0, 0, 52, 19, colors.white);
    paintutils.drawFilledBox(1, 1, sWidth, sHeight, colors.black);

    local fPos = getBoardCoords(Fruit);

    paintutils.drawPixel(fPos[1], fPos[2], colors.orange);

    for p in ipairs(Player) do
        drawPlayer(Player[p]);
    end
end

local function main()
    local event, char = os.pullEvent("char");

    local playerBuffer = Player[1];
    local currentBuffer;

    moveHead(char);

    for p in ipairs(Player) do
        if p > 1 then
            currentBuffer = Player[p];
            Player[p] = playerBuffer;
            playerBuffer = currentBuffer;
        end
    end

    draw();
end

while true do 
    main();
end
