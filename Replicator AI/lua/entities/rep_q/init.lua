/*
	Replicator_Q for GarrysMod10
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
	self.max_groupies = 0;
end

--################# Select Schedule @JDM12989
function ENT:SelectSchedule()
	local energy = 100;
	--[[if (Replicators.RD) then
		energy = RD_GetResourceAmount(self,"energy");
	end
	-- find energy
	if (energy == 0) then
		--self:StartSchedule(self:Move(self:Find("energy")));
	end]]
	-- replicate
	if (energy >= 100 and self.materials >= 200) then
		--spawn
		local pos = self:GetPos() + self:GetForward()*60;
		--local tbl = ents.FindInSphere(pos,1);
		--if (#tbl == 1 and tbl[1] == self) then
			local rep = ents.Create("rep_n");
			rep:SetPos(pos);
			rep:Spawn();
			if (Replicators.RD) then
				RD_ConsumeResource(self,"energy",100);
			end
			self.materials = self.materials - 200;
		--end
	end
end
