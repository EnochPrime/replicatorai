/*
	Replicators for GarrysMod10
	Copyright (C) 2007  aVoN

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

Msg("Replicator Core Library Initialized\n");
Replicators = Replicators or {};
Replicators.blocks = {};
Replicators.reps = {};
Replicators.nrq = {};
	Replicators.nrq["npc_rep_n"] = 20;	--temp
	Replicators.nrq["rep_n"] = 20;
	Replicators.nrq["rep_q"] = 0;
	Replicators.nrq["rep_h"] = 0;

function Replicators.Add(e)
	local class = e:GetClass();
	if (class == "block") then
		table.insert(Replicators.blocks,e);
	end
end

function Replicators.Remove(e)
	local class = e:GetClass();
	if (class == "block") then
		for k,v in pairs(Replicators.blocks) do
			if (v == e) then
				table.remove(Replicators.blocks,k);
			end
		end
	end
end
