
wifi_cfg={}
wifi_cfg.ssid = "NodemcuRoute"            --设置ssid
wifi_cfg.pwd = "NodemcuRoute123"       --密码
wifi_cfg.save=true
wifi_hostname = "Node-driver"   --主机名


wifi.sta.sethostname(wifi_hostname)   --�柚弥骰�
wifi.setmode(wifi.STATION)            --客户端模式
wifi.sta.config(wifi_cfg)  --配置ssid和密码
wifi.sta.autoconnect(1)


wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(info)  
    ip , nm , gateway = wifi.sta.getip()
    rssi = wifi.sta.getrssi()
    print("[wifi] 连接到wifi"..wifi_cfg.ssid)
    print("[wifi] ip:"..info.IP)
    print("[wifi] 子网掩码:"..info.netmask)
    print("[wifi] 网关:"..info.gateway)
    print("[wifi] 信号强度:"..rssi)
    --init_continue()
    wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED,function(info)
        --uinit()
        print('lot of wifi')
    end)
end)
