--################# Add NPC's to tab @JDM12989
function Replicators.AddNPCS()
	local cat = "Replicators"
	local NPC = {Name = "Replicator",Class = "rep_n",Category = cat};
	list.Set("NPC",NPC.Class,NPC);
	NPC = {Name = "Replicator Queen",Class = "rep_q",Category = cat};
	list.Set("NPC",NPC.Class,NPC);
	NPC = {Name = "Human-Form",Class = "rep_h",Category = cat};
	list.Set("NPC",NPC.Class,NPC);
end

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

Replicators.AddNPCS();