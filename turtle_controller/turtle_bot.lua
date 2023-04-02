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

while true do
    eventData = {os.pullEvent("modem_message")}
    cInput = eventData[5];
    print(turtle.getFuelLevel())
    if cInput == "w" or cInput == "W" then
        turtle.forward()
    elseif cInput == "d" or cInput == "D" then
        turtle.turnRight();
    elseif cInput == "a" or cInput == "A" then
        turtle.turnLeft();
    elseif cInput == "s" or cInput == "S" then
        turtle.back()
    elseif cInput == "e" or cInput == "E" then
        if currentAction == "dig" then
            turtle.dig()
        elseif currentAction == "attack" then
            turtle.attack()
        end
    elseif cInput == " " then
        turtle.up()
    elseif cInput == "z" or cInput == "Z" then
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
