/*
	Replicator_N for GarrysMod10
	Copyright (C) 2008  JDM12989

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

--################# HEADER #################
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

--################# SENT CODE #################

--################# Init @JDM12989
function ENT:Initialize()
	self.BaseClass.Initialize(self);
	self.max_materials = 100;
end

--################# Select Schedule @JDM12989
function ENT:SelectSchedule()
	if (self.freeze) then return end;
	--self.ai = false;
	if (self.ai == "base_ai") then
		-- if low numbers then resort to the start up code
		--if (#Replicators.Reps <= 10) then
			--self.BaseClass.SelectSchedule();
		--else
			local wander = false;
			self.attack = self:AttackWho();
			if (not self:Rep_AI_Attack(self.attack)) then
				if (#Replicators.Reps < Replicators.Limit) then
					if (self.materials < self.max_materials) then
						local e = self:Find("prop_physics");
						wander = not self:Rep_AI_Follow(e);
					else
						local e = self:Find("rep_q");
						wander = not self:Rep_AI_Follow(e);
					end
				else
					wander = true;
				end
			end
			
			if (wander) then
				self:Rep_AI_Wander();
			end
		--end
	else
		RunString(self.code);
	end
end

-- eventual final code (hopefully)
-- attack, if no one to attack, gather, if nothing to gather, wander
function ENT:TestCode()
	if (self.freeze) then return end;
	if (self.ai == "base_ai") then
		-- something in here for making a queen and such
		self.attack = self:AttackWho();
		if (not self:Rep_AI_Attack(self.attack)) then
			if (not self:Rep_AI_Gather()) then
				self:Rep_AI_Wander();
			end
		end
	else
		RunString(self.code);
	end
end
