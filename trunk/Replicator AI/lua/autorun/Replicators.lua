Replicators = Replicators or {};

function Replicators.Load()
	MsgN("=======================================================");
	local fn = "";
	if (SERVER) then
		fn = file.FindInLua("replicators/server/lib.lua")[1];
		include("replicators/server/"..fn);
		MsgN("Including: "..fn);
	elseif (CLIENT) then
		for _,file in pairs(file.FindInLua("replicators/vgui/*.lua")) do
			fn = file;
			include("replicators/vgui/"..fn);
			AddCSLuaFile("replicators/vgui/"..file);
			MsgN("Including: "..fn);
		end
	end
	fn = file.FindInLua("replicators/shared/list_reps.lua")[1];
	include("replicators/shared/"..fn);
	if (SERVER) then
		AddCSLuaFile("replicators/shared/"..fn);
	end
	MsgN("Including: "..fn);
	fn = file.FindInLua("replicators/shared/rd.lua")[1];
	include("replicators/shared/"..fn);
	if (SERVER) then
		AddCSLuaFile("replicators/shared/"..fn);
	end
	MsgN("Including: "..fn);
	MsgN("Replicator Core Library Initialized");
	MsgN("=======================================================");
end
Replicators.Load();