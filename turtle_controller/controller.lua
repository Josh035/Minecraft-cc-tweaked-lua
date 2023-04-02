local modem = peripheral.wrap("back")

modem.open(1)

while true do
    local eventData = {os.pullEvent("char")}
    local cInput = eventData[2];
    
    print(cInput)
    modem.transmit(1, 1, cInput);
end

