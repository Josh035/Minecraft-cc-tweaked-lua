local Player = {{1, 1}, {1, 0}}
local Fruit = {5, 5}
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

-- moves the head of the player (snake), depending of the input provided by the user
local function moveHead(player, char)
    -- maps the input char to the corresponding movement of the player head
    -- NOTE: of course lua doesn't have a switch case statement, why would it?
    if (char):lower() == "d" then
        player[1] = player[1] + 1;
    elseif (char):lower() == "a" then
        player[1] = player[1] - 1;
    elseif (char):lower() == "s" then
        player[2] = player[2] + 1;
    elseif (char):lower() == "w" then
        player[2] = player[2] - 1;
    end

    -- makes the player wrap around the screen
    if player[1] > sWidth then
        player[1] = 1;
    end

    if player[1] < 1 then
        player[1] = sWidth;
    end

    if player[2] > sHeight then
        player[2] = 1;
    end

    if player[2] < 1 then
        player[2] = sHeight
    end

    -- collision check and action for collecting food
    -- TODO: add validation, so that food doesn't spawn inside the player
    -- Idea for food validation: add numbers to coord, while the food is on the snake
    if player[1] == Fruit[1] and player[2] == Fruit[2] then
        Fruit[1] = math.floor(math.random(1, sWidth))
        Fruit[2] = math.floor(math.random(1, sHeight))

        Player[#Player + 1] = {Player[#Player][1], Player[#Player][2]};
    end
end

local function cyclePlayers(player, prevPlayer)
    player[1]=prevPlayer[1];
    player[2]=prevPlayer[2];
end

local function drawPlayer(player)
    paintutils.drawPixel(player[1], player[2], colors.red);
end

local function draw()
    paintutils.drawBox(0, 0, 52, 19, colors.white);
    paintutils.drawFilledBox(1, 1, sWidth, sHeight, colors.black);

    paintutils.drawPixel(Fruit[1], Fruit[2], colors.orange);

    for p in ipairs(Player) do
        drawPlayer(Player[p]);
    end
end

local function main()
    local event, char = os.pullEvent("char");

    local playerBuffer = {Player[1][1], Player[1][2]};
    local currentBuffer;

    moveHead(Player[1], char);

    for p in ipairs(Player) do
        if p > 1 then
            currentBuffer = {Player[p][1], Player[p][2]};
            cyclePlayers(Player[p], playerBuffer)
            playerBuffer = currentBuffer;
        end
    end

    draw();
end

while true do 
    main();
end
