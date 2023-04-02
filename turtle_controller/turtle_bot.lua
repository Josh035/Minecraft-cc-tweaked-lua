modem = peripheral.wrap("right")

if not modem then return end;

modem.open(1);

local eventData;
local cInput;
local currentAction;
local currentSlot = 1;

local function setCurrentAction()
    local itemInfo = turtle.getItemDetail()

    if itemInfo ~= nill then
        local name = itemInfo["name"];
        if name == "minecraft:diamond_sword" then
            currentAction = "attack"
        elseif name == "minecraft:diamond_pickaxe" then
            currentAction = "dig";
        end
    end
end

turtle.equipLeft();
setCurrentAction()
turtle.equipLeft();

while true do
    eventData = {os.pullEvent("modem_message")}
    cInput = eventData[5];
    print(turtle.getFuelLevel())
    if (cInput):lower() == "w" then
        turtle.forward()
    elseif (cInput):lower() == "d" then
        turtle.turnRight();
    elseif (cInput):lower() == "a" then
        turtle.turnLeft();
    elseif (cInput):lower() == "s" then
        turtle.back()
    elseif (cInput):lower() == "e" then
        if currentAction == "dig" then
            turtle.dig()
        elseif currentAction == "attack" then
            turtle.attack()
        end
    elseif cInput == " " then
        turtle.up()
    elseif (cInput):lower() == "z" then
        turtle.down()
    elseif cInput == "1" then
        if currentSlot > 1 then
            currentSlot = currentSlot - 1;
        end
        if turtle.getItemDetail() == nil then turtle.equipLeft() end;
        turtle.select(currentSlot)
        setCurrentAction()
        turtle.equipLeft()
    elseif cInput == "2" then
        if currentSlot < 16 then
            currentSlot = currentSlot + 1;
        end
        if turtle.getItemDetail() == nil then turtle.equipLeft() end;
        turtle.select(currentSlot)
        setCurrentAction()
        turtle.equipLeft()
    end
end
