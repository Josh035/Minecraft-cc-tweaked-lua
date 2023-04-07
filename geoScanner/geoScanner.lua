
local function main()
    local geoScanner = peripheral.wrap("right");

    if (geoScanner) then
        local chunkInfo = geoScanner.chunkAnalyze();

        for c in ipairs(chunkInfo) do
            print(chunkInfo[c])
        end
    end
end

main()
