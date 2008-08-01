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
	-- if low numbers then resort to the start up code
	--if (#Replicators.Reps <= 10) then
		--self.BaseClass.SelectSchedule();
	--else
		self.attack = self:AttackWho();
		self.tasks = false;
		local i = 1;
		while (not self.tasks and i < #self.code) do
			local s = self.code[i];
			RunString(s);
			i = i + 1;
		end
	--end
end
