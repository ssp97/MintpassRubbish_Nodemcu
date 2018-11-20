
USER_ID   = "2001370210"
KEY       = "56b74108e785b589"
DEV_CLASS = 'A'
HOST      = "115.28.93.201"
PORT      = 7005
VER       = "32"

udpSocket = net.createUDPSocket()

function packSend(data)
    local status = "1234"
    local packet_class = "01"
    local sta = data
    local packet_len = string.format("%04d",41+string.len(sta))
    packet = packet_len..VER..DEV_CLASS..packet_class..USER_ID..KEY..status..sta..'05'
    if (DEBUG) then print("[UDP ] 发送数据包"..packet) end
    udpSocket:send(PORT,HOST,packet)
end

function heartBeat(text)
    packSend("01"..text)
end

function warning(text)
    packSend("02"..text)
end

function ValUpload(id,data)
    sta = string.format("0B%s1%03d%d%s",USER_ID,id,#data,data)
    packSend(sta)
end

function packRece(s,data,serverport,serverip)
    if (DEBUG) then
        print("[UDP ] 接收到数据："..data)
        print(string.format("[UDP ] 来自服务器: %s:%d",serverip, serverport))
    end
    local cls = string.sub(data,8,9)
    if(cls == "01") then
        local  code =  string.sub(data,14,15)
        if    (code == "01") then
            print("[UDP ] 收到心跳包回复")
        elseif(code == "02") then
            print("[UDP ] 报警上传成功")
        elseif(code == "03") then
            print("[UDP ] 获取到公网ip")
        end
    elseif (cls == "08") then
        local cmdEnd = tonumber(string.sub(data,1,4))-36+33
        local cmd    = string.sub(data,34,cmdEnd)
        print("[UDP ] 接收到命令"..cmd)
        fuhome_callback(cmd)
        packSend(string.format("09%sOK",string.sub(data,14,23)))
    end
end

udpSocket:on("receive", packRece)

--warning("閽熷伐鍨冨溇") --钟工垃圾
