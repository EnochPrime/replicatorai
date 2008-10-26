-- list of attackers
Replicators.Attackers = {};
-- list of replicators
Replicators.Reps = {};
-- maximum number of replicators
CreateConVar("replicator_limit","25",false);
-- Humanform numer
Replicators.Human_Number = 1;
-- required blocks for types
Replicators.RequiredNumber = {};
Replicators.RequiredNumber["rep_n"] = 20;
Replicators.RequiredNumber["rep_q"] = 50;
-- booleans for other addons
Replicators.HasRD = Dev_Link or #file.FindInLua("weapons/gmod_tool/stools/dev_link.lua") == 1;
Replicators.HasCD = #file.FindInLua("autorun/server/sv_cds_core.lua") == 1;
Replicators.HasGC = #file.FindInLua("weapons/gmod_tool/stools/gcombat.lua") == 1;
Replicators.HasSG = #file.FindInLua("autorun/stargate.lua") == 1;
-- ARG tables
Replicators.Immunities = {};
Replicators.FreqLog = {};
Replicators.ImmuneAfter = 5;

-- find precendence & model ignore lists
Replicators.FindMe = {"prop_physics"};
Replicators.IgnoreMe = {
	"models/Zup/ramps/brick_01.mdl",
	"models/Zup/ramps/brick_01_small.mdl",
	"models/Zup/ramps/sgc_ramp.mdl",
	"models/Zup/ramps/sgc_ramp_small.mdl",
	"models/Zup/sg_rings/ring.mdl",
};

--################# Register NPC @JDM12989
function Replicators.Add(e)
	Replicators.Reps[e.ENTINDEX] = e;
end

--################# Remove NPC @JDM12989
function Replicators.Remove(e)
	table.remove(Replicators.Reps,e.ENTINDEX);
	if (table.Count(Replicators.Reps) == 0) then
		Replicators.Attackers = {};
		Replicators.Immunities = {};
		Replicators.FreqLog = {};
	end
end

--################# Returns a replicator that is available for joining a group
function Replicators.GetAvailable(pos)
	local reps = {};
	--local exclude = table.Count(Replicators.Reps) / 2;
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
	if (#Replicators.Attackers > 0 and not table.HasValue(Replicators.Attackers,p)) then
		table.insert(Replicators.Attackers,p);
	else
		table.ForceInsert(Replicators.Attackers,p);
	end
end

--################# Remove Attacker @JDM12989
function Replicators.RemoveAttacker(p)
	for k,v in pairs(Replicators.Attackers) do
		if (v == p) then
			table.remove(Replicators.Attackers,k);
		end
	end
end
hook.Add("PlayerDeath","RemoveFromAttackers",Replicators.RemoveAttacker);

--################# ARG Immunity handling @JDM12989
function Replicators.ARG(freq)
	local freq_count = (Replicators.FreqLog[freq] or 0) + 1;
	Replicators.FreqLog[freq] = freq_count;
	if (freq_count >= Replicators.ImmuneAfter) then
		Replicators.Immunities[freq] = freq;
	end
	if (#Replicators.Immunities == 0) then return true end;
	if (table.HasValue(Replicators.Immunities,freq)) then return false end;
	return true;
end
