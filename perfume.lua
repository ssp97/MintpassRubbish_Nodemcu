function perfume_init()
    gpio.mode(5, gpio.OUTPUT)
    gpio.write(5, 0)
    perfume_used = 0
end

function perfume_use(n)
    if perfume_used == 0 then
        gpio.write(5, 1)
        perfume_used = 1
        tmr.create():alarm(n*1000, tmr.ALARM_SINGLE, function()
            gpio.write(5, 0)
            perfume_used = 0
        end)
    else 
        print('perfume was used')
    end
end


perfume_init()