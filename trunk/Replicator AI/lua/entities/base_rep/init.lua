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

--################# SENT CODE #################
ENT.CDSIgnore = true;
function ENT:gcbt_breakactions() end; ENT.hasdamagecase = true;

--################# Init @JDM12989
function ENT:Initialize()
	self.ENTINDEX = self:EntIndex();
	self:SetModel(self.Model);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_STEP);
	self:SetSolid(SOLID_BBOX);
	self:SetHullType(self.Hull);
	self:SetHullSizeNormal();
	self:CapabilitiesAdd(CAP_MOVE_GROUND);
	self:SetMaxYawSpeed(5000);
	self:SetNWInt("Health",self.Max_Health);
	Replicators.Add(self);
	
	self.ai = "replicators/"..self:GetClass()..".txt";
	self.code = {};
	self:SetCode(self.ai);
	self.freeze = false;
	self.groupies = {};
	self.leader = nil;
	self.tasks = false;
	
	self:AddResource("energy",100000);
	self.material_metal = 0;
	self.material_other = 0;
	self.material_max = 5000;
	
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake();
	end
end

--################# On Take Damage @JDM12989
function ENT:OnTakeDamage(dmg)
	local att = dmg:GetAttacker();
	local dam = dmg:GetDamage();
	Replicators.AddAttacker(att);
	local health = self:GetNWInt("Health");
	self:SetNWInt("Health",math.Clamp(health-dam,0,self.Max_Health));
	if (self:GetNWInt("Health") == 0) then
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
			end
		end
	end
end

--################# Select Schedule @JDM12989
function ENT:SelectSchedule()
	local energy = self:GetResource("energy",1000);
	
	-- run away from people
	-- form queen or gather more material & energy
	if (energy >= 1000 and self.materials >= 1000) then
		self:ConsumeResource("energy",1000);
		self.materials = self.materials - 1000;
		Replicators.Remove(self);
		self:Remove();
		local e = ents.Create("rep_q");
		e:SetPos(self:GetPos());
		e:Spawn();
	else
		if (not self:Rep_AI_Gather(1000)) then
			if (not self:Rep_AI_Follow(self:Find("Zero_Point_Module"))) then
				self:Rep_AI_Wander();
			end
		end
	end
end

--################# Allows the code to be changed @JDM12989
function ENT:SetCode(code)
	local t = {};
	local s = "";
	if (file.Exists(code)) then
		s = file.Read(code);
	elseif (file.Exists("../../../data/"..code)) then
		s = file.Read("../../../data/"..code);
	else
		return;
	end
	s = string.Replace(s,"self","ents.GetByIndex("..self.ENTINDEX..")");
	t = string.Explode(";",s);
	self.ai = code;
	self.code = t;
	
	self:SetSchedule(SCHED_NONE);
end

--################# Retrieve the currently running code's name @JDM12989
function ENT:GetAI()
	return self.ai;
end

--################# Retrieve the currently running code @JDM12989
function ENT:GetCode()
	return self.code;
end
