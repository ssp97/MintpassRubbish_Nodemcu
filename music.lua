function music_init()
    uart.setup(1, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1)
end

function music(i)
    uart.write(1,0x7E,0x05,0x41,0x00,i,0x44+i,0xEF)
end

music_init()