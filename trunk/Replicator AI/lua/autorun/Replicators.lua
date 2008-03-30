/*
	Replicators for GarrysMod10
	Copyright (C) 2008 JDM12989

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

MsgN("=======================================================");
MsgN("Replicator Core Library Initialized");
MsgN("=======================================================");

Replicators = Replicators or {};
Replicators.Attackers = {};			-- list of attackers
Replicators.Blocks = {};			-- list of blocks
Replicators.Reps = {};				-- list of replicators
Replicators.Limit = 10;				-- maximum number of replicators
Replicators.RequiredNumber = {};	-- required blocks for types
	Replicators.RequiredNumber["npc_rep_n"] = 20;	--temp
	Replicators.RequiredNumber["rep_n"] = 20;
	Replicators.RequiredNumber["rep_q"] = 0;

function Replicators.Add(e)
	local class = e:GetClass();
	if (class == "block") then
		table.insert(Replicators.Blocks,e);
	end
	if (class == "rep_*") then
		table.insert(Replicators.Reps,e);
	end
end

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

function Replicators.Attacker(p)
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

function Replicators.RemoveAttacker(p,g,a)
	for k,v in pairs(Replicators.Attackers) do
		if (v == p) then
			table.remove(Replicators.Attackers,k);
		end
	end
end
hook.Add("PlayerDeath","RemoveFromAttackers",Replicators.RemoveAttacker);