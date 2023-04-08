local ed = peripheral.wrap("right")
local arCtr = peripheral.wrap("top")

local lineCount = 1;

local function print2Ar(name, value)
    arCtr.writeString(name .. ": " .. value, 10, 10 * lineCount, 0xffffff);
    lineCount = lineCount + 1;
end

local function main()
    local timeTicks = ed.getTime()
    arCtr.clear();

    local days = math.floor(timeTicks / 24000)
    local hours = math.floor((timeTicks - days) / 1000);
    local mins = (timeTicks - (days + hours)) / 16;

    lineCount = 1;

    os.sleep(10)
end

main()
