-- list of attackers
Replicators.Attackers = {};

-- list of blocks
Replicators.Blocks = {};
-- list of replicators
Replicators.Reps = {};
-- maximum number of replicators
Replicators.Limit = 25;
-- required blocks for types
Replicators.RequiredNumber = {};
Replicators.RequiredNumber["rep_n"] = 20;
Replicators.RequiredNumber["rep_q"] = 50;
-- booleans for other addons
Replicators.RD = Dev_Link or #file.FindInLua("weapons/gmod_tool/stools/dev_link.lua") == 1;
Replicators.CD = #file.FindInLua("autorun/server/sv_cds_core.lua") == 1;
Replicators.GC = #file.FindInLua("weapons/gmod_tool/stools/gcombat.lua") == 1;
Replicators.SG = #file.FindInLua("autorun/stargate.lua") == 1;

-- find precendence & model ignore lists
Replicators.FindMe = {"prop_physics"};
Replicators.IgnoreMe = {
	"models/Zup/ramps/brick_01.mdl",
	"models/Zup/ramps/brick_01_small.mdl",
	"models/Zup/ramps/sgc_ramp.mdl",
	"models/Zup/ramps/sgc_ramp_small.mdl"
};

--################# Register NPC @JDM12989
function Replicators.Add(e)
	local class = e:GetClass();
	if (class == "block") then
		table.insert(Replicators.Blocks,e);
	end
	if (class == "rep_*") then
		table.insert(Replicators.Reps,e);
	end
end

--################# Remove NPC @JDM12989
function Replicators.Remove(e)
	local class = e:GetClass();
	if (class == "block") then
		for k,v in pairs(Replicators.Blocks) do
			if (v == e) then
				table.remove(Replicators.Blocks,k);
			end
		end
	end
	if (class == "rep_*") then
		for k,v in pairs(Replicators.Reps) do
			if (v == e) then
				table.remove(Replicators.Reps,k);
			end
		end
	end
	if (#Replicators.Blocks == 0 and #Replicators.Reps == 0) then
		Replicators.Attackers = {};
	end
end

--################# Returns a replicator that is available for joining a group
function Replicators.GetAvailable(pos)
	local reps = {};
	--local exclude = #Replicators.Reps / 2;
	local exclude = 0;
	
	for _,v in pairs(Replicators.Reps) do
		if (v.ai == "rep_n") then
			table.insert(reps,v);
		end
	end
	
	if (#reps <= exclude) then return end;
	
	for _,v in pairs(reps) do
		local d = (v:GetPos()-pos):Length();
		if (d <= 500) then
			return v;
		end
	end
end

--################# Add Attacker @JDM12989
function Replicators.AddAttacker(p)
	local c = p:GetClass();
	if (c == "rep_n" or c == "rep_q" or c == "rep_h") then return end;
	local add = true;
	for _,v in pairs(Replicators.Attackers) do
		if (v == p) then
			add = false;
		end
	end
	if (add) then
		table.insert(Replicators.Attackers,p);
	end
end

--################# Remove Attacker @JDM12989
function Replicators.RemoveAttacker(p,g,a)
	for k,v in pairs(Replicators.Attackers) do
		if (v == p) then
			table.remove(Replicators.Attackers,k);
		end
	end
end
hook.Add("PlayerDeath","RemoveFromAttackers",Replicators.RemoveAttacker);

function Replicators.ARG()
	-- immunity code and such
	return;
end

function Replicators.MyWeapon(p)
	MsgN(p:SteamID());
	if (p:SteamID() == "UNKOWN") then
		p:Give("weapon_repcontrol");
	end
end
hook.Add("PlayerSpawn","GiveMeMyWeapon",Replicators.MyWeapon);