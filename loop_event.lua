


function door_init()
    main_tmr = tmr.create()
    fuhome_tmr = tmr.create()
    loop_time = 0
    fuhome_time = 0
    servo_off()
    main_tmr:alarm(500,tmr.ALARM_SINGLE,door_off_loop)
    fuhome_tmr:alarm(10000,tmr.ALARM_SINGLE,heart)
    main_tmr:start()
end

function heart()
    if fuhome_time%60 == 0 then
        if infrared_read(0) == 1 then
            if infrared_read(1) == 1 then
                warning("垃圾箱已满")
                
            else
                warning("可回收垃圾箱已满")
            end
        elseif infrared_read(1) == 1 then
            warning("不可垃圾箱已满")
        end
        ValUpload("100",string.format("%d",infrared_read(0)))
        ValUpload("101",string.format("%d",infrared_read(1)))
    end
    heartBeat("ok")
    fuhome_tmr:alarm(10000,tmr.ALARM_SINGLE,heart)
    fuhome_time = fuhome_time+1
end

function door_on_loop()
    print("door on"..loop_time)
    if ultrasonic_do() < 100 then
        loop_time = 0
    end

    if loop_time > 7 then
        servo_off()
        perfume_use(3)
        main_tmr:alarm(500,tmr.ALARM_SINGLE,door_off_loop)
    else
        main_tmr:alarm(500,tmr.ALARM_SINGLE,door_on_loop)
    end
    
    loop_time = loop_time +1
end

function door_off_loop()
    print("door off")
    
    if ultrasonic_do() <30 then
        if infrared_read(0) == 1 then
            if infrared_read(1) == 1 then
                music_num = 2
            else
                music_num = 1
            end
        elseif infrared_read(1) == 1 then
            music_num = 0
        else 
            music_num = 3
        end
        servo_on()
        music(music_num)
        loop_time = 0
        main_tmr:alarm(500,tmr.ALARM_SINGLE,door_on_loop)
    else
        main_tmr:alarm(500,tmr.ALARM_SINGLE,door_off_loop)
    end
end

function door_on_wifi()
    print("door on with wifi")
    servo_on()
    main_tmr:alarm(500,tmr.ALARM_SINGLE,door_on_wifi)
end

function door_off_wifi()
    servo_off()
    main_tmr:alarm(500,tmr.ALARM_SINGLE,door_off_loop)
end

door_init()