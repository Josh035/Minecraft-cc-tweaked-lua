
local function main()
    local geoScanner = peripheral.wrap("right");

    if (geoScanner) then
        local chunkInfo = geoScanner.chunkAnalyze();

    end
end

main()
