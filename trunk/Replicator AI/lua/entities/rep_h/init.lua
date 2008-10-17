/*
	Replicator_H for GarrysMod10
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
	self.Male = file.Find("../models/Humans/Group01/Male_*.mdl");
	self.Female = file.Find("../models/Humans/Group01/Female_*.mdl");
	self.Model = self:GetHumanModel();
	self.BaseClass.Initialize(self);
end

function ENT:GetHumanModel()
	local model = "models/gman.mdl";
	if (Replicators.Human_Number == 1) then
		model = "models/gman.mdl";
	else
		if (Replicators.Human_Number % 2 == 0) then
			-- make girl
			model = "models/Humans/Group01/"..self.Female[math.random(1,#self.Female)];
		else
			-- make guy
			model = "models/Humans/Group01/"..self.Male[math.random(1,#self.Male)];
		end
	end
	Replicators.Human_Number = Replicators.Human_Number + 1;
	return model;
end

  
function ENT:SelectSchedule()
	if (self.freeze) then return end;
	-- if low numbers then resort to the start up code
--	if (#Replicators.Reps <= 1) then
--		self.BaseClass.SelectSchedule();
--	else
		self.attack = self:AttackWho();
		self.tasks = false;
		local i = 1;
		local code = self:GetCode();
		while (not self.tasks and i < #code) do
			local s = code[i];
			RunString(s);
			i = i + 1;
		end
--	end
end
