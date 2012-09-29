if SERVER then
	local function getfiles(dir)
		local files
		
		if VERSION >= 150 then
			local a, b = file.Find(dir .. "*", "LUA")
			
			files = {}
			
			for k,v in pairs(a) do
				table.insert(files, v)
			end
			
			for k,v in pairs(b) do
				table.insert(files, v)
			end
		else
			files = file.FindInLua(dir .. "*")
		end
			
		return files
	end
		
	AddCSLuaFile("autorun/pac_init.lua")
		
	local function add_files(dir)		
		for _, name in pairs(getfiles(dir)) do
			if name:sub(-4) == ".lua" then
				AddCSLuaFile(dir .. name)
			elseif not name:find(".", nil, true) then
				add_files(dir .. name .. "/")
			end
		end
	end
	
	add_files("pac3/core/client/")

	include("pac3/core/server/init.lua")
end

if CLIENT then
	include("pac3/core/client/init.lua")
end