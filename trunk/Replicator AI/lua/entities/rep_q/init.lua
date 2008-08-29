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
	self.max_groupies = 10;
end

--################# Select Schedule @JDM12989
function ENT:SelectSchedule()
	-- remove nil values from table
	while (table.HasValue(self.groupies,nil)) do
		for k,v in pairs(self.groupies) do
			if (v == nil) then
				table.remove(self.groupies,k);
			end
		end
	end
	
	-- get more groupies if possible
	if (#self.groupies < self.max_groupies) then
		local new_groupie = Replicators.GetAvailable(self:GetPos());
		if (ValidEntity(new_groupie)) then
			table.insert(self.groupies,new_groupie);
			new_groupie.leader = self;
			new_groupie:SetCode("rep_n_group");
		end
	end
	
	if (#Replicators.Reps >= Replicators.Limit) then return end;
	local energy = self:GetResource("energy",100);
	energy = 100; -- temp until finding energy is complete
	--[[ find energy
	if (energy == 0) then
		--self:StartSchedule(self:Move(self:Find("energy")));
	end]]
	-- replicate
	if (energy >= 100 and self.materials >= 200) then
		--spawn new rep
		local pos = self:GetPos() + self:GetForward()*60;
		local rep = ents.Create("rep_n");
		rep:SetPos(pos);
		rep:Spawn();
		self:ConsumeResource("energy",100);
		self.materials = self.materials - 200;
	end
	--[[  commented out because stupid ents.Create cause a nil value error!
	local pos = self:GetPos() + (self:GetForward() * 60);
	if (energy >= 100 and self.materials >= 20) then
		--spawns blocks
		local block = ents.Create("block");
		block:SetPos(pos);
		block:Spawn();
		self:ConsumeResource("energy",100);
		self.materials = self.materials - 20;
	end

	local blocks_near = {};
	local ents = ents.FindInSphere(pos,60);
	for _,v in pairs(ents) do
		if (v:GetClass() == "block") then
			table.insert(blocks_near,v);
		end
	end
	if (#blocks_near >= Replicators.RequiredNumber["rep_n"]) then
		-- remove blocks
		for _,v in pairs(blocks_near) do
			v:Remove();
		end
		-- spawn rep
		local rep = ents.Create("rep_n");
		rep:SetPos(pos);
		rep:Spawn();
	end													]]
end
