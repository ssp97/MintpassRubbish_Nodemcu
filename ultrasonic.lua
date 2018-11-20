function ultrasonic_init()
    --ULTRASONIC_ECHO = 1
    --ULTRASONIC_TRIG = 2
    gpio.mode(1, gpio.INPUT)
    gpio.mode(2, gpio.OUTPUT)
    gpio.write(1,0)
end

function ultrasonic_do()
    gpio.mode(2, gpio.OUTPUT)
    gpio.mode(1, gpio.INPUT)
    gpio.write(2,1)
    tmr.delay(10)
    gpio.write(2,0)
    local i=50
    while(i)do
        if gpio.read(1)==1 then break end
        i = i-1
    end
    if i==0 then return -1 end
    local ultrasonic_start = tmr.now()
    local i=50
    while(i)do
        if gpio.read(1)==0 then break end
        i = i-1
    end
    local ultrasonic_time = tmr.now()-ultrasonic_start
    if i==0 then return -2 end
    if ultrasonic_time > 50000 then return -3 end
    return ((ultrasonic_time)/2 * 0.034)
end

function ultrasonic()
    while(1) do
        local data = ultrasonic_do()
        if data > 0 then return data end
    end
end

ultrasonic_init()