function servo_init()
    servo_off()
    
end

function servo(i)
    pwm.setduty(8,i)
end

function servo_on()
    pwm.setup(8, 20, 10)
    servo(10)
end

function servo_off()
    pwm.setup(8, 20, 22)
    servo(22)
    tmr.create():alarm(500, tmr.ALARM_SINGLE, function()
            pwm.stop(8)
    end)
end

servo_init()