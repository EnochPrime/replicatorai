/*
	Replicator Basecode for GarrysMod10
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
MsgN("=======================================================");
MsgN("Replicator Base Code Initializing...");
for _,file in pairs(file.FindInLua("entities/base_rep/modules/*.lua")) do
	MsgN("Initializing: "..file);
	include("modules/"..file);
end
MsgN("Replicator Base Code Initialized Successfully");
MsgN("=======================================================");

--################# SENT CODE #################

--################# Init @JDM12989
function ENT:Initialize()
	self.ENTINDEX = self:EntIndex();
	self:SetModel(self.Model);
	--self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_STEP);
	self:SetSolid(SOLID_BBOX);
	self:SetHullType(self.Hull);
	self:SetHullSizeNormal();
	self:CapabilitiesAdd(CAP_MOVE_GROUND);
	self:SetMaxYawSpeed(5000);
	self:SetHealth(self.Health);
	Replicators.Add(self);
	
	self.ai = "base_ai";
	self.code = "";
	self:SetCode(self.ai);
	self.freeze = false;
	self.groupies = 0;
	self.leader = nil;
	self.materials = 0;
	
	if (Replicators.RD) then
		LS_RegisterEnt(self,"Storage");
		RD_AddResource(self,"energy",100000);
	end
	
	--self:AddUndo(self:GetOwner(),self);
	--self:AddCleanup(self:GetOwner(),self);
end

--################# On Take Damage @JDM12989
function ENT:OnTakeDamage(dmg)
	local att = dmg:GetAttacker();
	local dam = dmg:GetDamage();
	Replicators.AddAttacker(att);
	self:SetHealth(self:Health() - dam);
	if (self:Health() <= 0) then
		if (dmg:IsBulletDamage() or (dmg:IsExplosionDamage() and dam < 100) or dam == 100) then
			--fall apart
			Replicators.Remove(self);
			self:Remove();
			-- MAKE THEM WORK THE CORRECT WAY!!!
			local str = "models/JDM12989/Replicators/"..self:GetClass().."/Gibs/";
			for i=1,#file.Find("../"..str.."*.mdl") do
				local gib = ents.Create("block");
				gib:SetPos(self:GetPos());
				gib:SetAngles(self:GetAngles());
				gib:Spawn();
				gib:SetModel(str..i..".mdl");
				gib:PhysicsInit(SOLID_VPHYSICS);
				gib:GetPhysicsObject():Wake();
				gib.dead = true;
				gib:OnRemove();
			end
		end
	end
end

--################# Select Schedule @JDM12989
function ENT:SelectSchedule()
	if (Replicators.RD) then
		local energy = RD_GetResourceAmount(self,"energy");
	else
		local energy = 1000;
	end
	-- run away from people
	-- find materials and energy
	if (self.materials < self.max_materials + 900) then
		self:StartSchedule(self:Move(self:Find("prop_physics")));
	else
		self:StartSchedule(self:Move(self:Find("energy")));
	end
	-- form queen or gather more material
	if (energy >= 1000 and self.materials >= 1000) then
		if (Replicators.RD) then
			self:ConsumeResource(self,"energy",1000);
		end
		self.materials = self.materials - 1000;
		-- blocks
		Replicators.Remove(self);
		self:Remove();
		local e = ents.Create("rep_q");
		e:SetPos(self:GetPos());
		e:Spawn();
	end
end

function ENT:SetCode(code)
	local str = file.Read("replicators/"..code..".txt");
	str = string.Replace(str,"self","ents.GetByIndex("..self.ENTINDEX..")");
	str = string.Replace(str,";","");
	self.code = str;
	self.ai = code;
end

