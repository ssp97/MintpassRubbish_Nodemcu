function infrared_init()
    gpio.mode(6, gpio.INPUT)
    gpio.mode(7, gpio.INPUT)
end

function infrared_read(n)
    return 1-gpio.read(n+6)
end

infrared_init()