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
		--if (#Replicators.Reps <= 10) then
			--self.BaseClass.SelectSchedule();
		--else
			self.attack = self:AttackWho();
			if (table.HasValue(ents.FindInSphere(self:GetPos(),5000),self.attack)) then
				self:StartSchedule(self:Move(self.attack));
			elseif (#Replicators.Reps < Replicators.Limit) then
				if (self.materials < self.max_materials) then
					-- gather materials
					self:StartSchedule(self:Move(self:Find("prop_physics")));
				else	
					-- bring back to queen
					self:StartSchedule(self:Move(self:Find("rep_q")));
				end
			else
				self:StartSchedule(self:Move());
			end
		--end
	else
		RunString(self.code);
	end
end
