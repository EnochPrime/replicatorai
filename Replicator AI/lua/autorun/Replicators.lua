Replicators = Replicators or {};

function Replicators.Load()
	MsgN("=======================================================");
	if (SERVER) then
		include("replicators/server/"..file.FindInLua("replicators/server/lib.lua")[1]);
		include("replicators/server/"..file.FindInLua("replicators/server/rd.lua")[1]);
	elseif (CLIENT) then
		for _,file in pairs(file.FindInLua("replicators/vgui/*.lua")) do
			include("replicators/vgui/"..file);
			AddCSLuaFile("vgui/"..file);
		end
	end
	include("replicators/shared/"..file.FindInLua("replicators/shared/list_reps.lua")[1]);
	MsgN("Replicator Core Library Initialized");
	MsgN("=======================================================");
end
Replicators.Load();