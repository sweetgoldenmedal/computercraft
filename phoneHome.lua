-- ref: http://www.computercraft.info/wiki/HTTP_(API)
apihost = settings.get("api.host")
apiport = settings.get("api.port")

local sExample = http.get("http://"..apihost..":"..apiport.."/")
write(sExample.readAll())
sExample.close()