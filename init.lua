local regex = require('regex')
local file = io.open(minetest.get_modpath("bannedwords") .. "/words.txt", "r");
local bannedwords = {}
for line in file:lines() do
   table.insert(bannedwords, line);
end

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end
 

print("BANNED WORDS LIST : " .. dump(bannedwords))


minetest.register_on_chat_message(function(name, message)
	local banned = 0
    for k,v in pairs(bannedwords) do
		local re, err = regex.new(v , "gi")
		if banned == 0 then
			if re:match(message,0) then
				xban.ban_player(name, "bannedwords:main", os.time(os.date("!*t")) + 7200, "Saying a banned word")
				banned = 1
			end
		end
	end
    return false
end)
		
