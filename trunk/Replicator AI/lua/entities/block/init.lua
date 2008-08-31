/*
	Replicator Block for GarrysMod10
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
	self:SetModel("models/JDM12989/Replicators/Block.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetCollisionGroup(COLLISION_GROUP_WORLD);
	self:DrawShadow(false);
	Replicators.Add(self);
	
	self.active = true;
	self.dead = false;
	self.timer_running = true;
	
	-- create a timer to start removale of block if nothing is going on
	timer.Create("block_delay_"..self.ENTINDEX,10,1,
		function()
			if (self and ValidEntity(self)) then
				self.dead = true;
				Replicators.Remove(self);
				self:OnRemove();
			end
		end
	);
	
	local phys = self:GetPhysicsObject();
	if (phys:IsValid()) then
		phys:Wake();
		phys:SetMass(1);
	end
end

--################# Spawn the Block @JDM12989
function ENT:SpawnFunction(p,t)
	if (not t.Hit) then return end;
	local e = ents.Create("block");
	e:SetPos(t.HitPos+Vector(0,0,10));
	e:Spawn();
	return e;
end

--################# When removing @JDM12989
function ENT:OnRemove()
	Replicators.Remove(self);
	self:SetNWBool("fade_out",true);
	-- actually remove after a while
	timer.Simple(5,
		function()
			if (self and ValidEntity(self)) then
				self:Remove();
			end
		end
	);
end

--################# Think @JDM12989
function ENT:Think()
	-- compatibility with ai_disabled check box
	local convar_ai = GetConVarNumber("ai_disabled");
	if (convar_ai == 1) then
		if (self.active) then
			timer.Pause("block_delay_"..self.ENTINDEX);
			self.active = false;
		end
		return;
	elseif (convar_ai == 0) then
		if (not self.active) then
			timer.UnPause("block_delay_"..self.ENTINDEX);
			self.active = true;
		end
	end
	
	if (self.dead) then
		if (not self.timer_running) then
			timer.Start("block_delay_"..self.ENTINDEX);
			self.timer_running = true;
		end
	else
		timer.Stop("block_delay_"..self.ENTINDEX);
	end
end
