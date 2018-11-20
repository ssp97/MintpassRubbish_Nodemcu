

function fuhome_callback(text)
    print("[backtrack]"..text)
    if text == "ljt-on" then
        door_on_wifi()
    elseif text == "ljt-off" then
        door_off_wifi()
    end
end
