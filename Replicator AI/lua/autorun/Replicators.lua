Replicators = Replicators or {};

function Replicators.Load()
	MsgN("=======================================================");
	local fn = "";
	if (SERVER) then
		for _,fn in pairs(file.FindInLua("replicators/server/*.lua")) do
			include("replicators/server/"..fn);
			MsgN("Including: "..fn);
		end
		for _,fn in pairs(file.FindInLua("replicators/vgui/*.lua")) do
			AddCSLuaFile("replicators/vgui/"..fn);
			MsgN("AddCSLua: "..fn);
		end
		AddCSLuaFile("autorun/Replicators.lua");
	elseif (CLIENT) then
		for _,fn in pairs(file.FindInLua("replicators/vgui/*.lua")) do
			include("replicators/vgui/"..fn);
			MsgN("Including: "..fn);
		end
	end
	
	for _,fn in pairs(file.FindInLua("replicators/shared/*.lua")) do
		include("replicators/shared/"..fn);
		if (SERVER) then
			AddCSLuaFile("replicators/shared/"..fn);
		end
		MsgN("Including: "..fn);
	end
	MsgN("Replicator Core Library Initialized");
	MsgN("=======================================================");
end
Replicators.Load();
