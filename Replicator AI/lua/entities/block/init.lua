/*
	Replicator Block for GarrysMod10
	Copyright (C) 2007  JDM12989

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
	self.ENTINDEX = self:EntIndex();
	self:SetModel("models/JDM12989/Replicators/Block.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetCollisionGroup(COLLISION_GROUP_WORLD);
	self:DrawShadow(false);
	Replicators.Add(self);
	
	self.active = true;
	self.dead = false;
	self.dist = 300;
	self.leader = nil;
	self.nir = 0;
	self.timer_run = true;
	--self.type = "rep_n";
	self.type = "npc_rep_n"; --temp
	
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
function ENT:SpawnFunction(p,t,sd,typ) --(sd = spawn dead | typ = type)
	if (not t.Hit) then return end;
	local e = ents.Create("block");
	e:SetPos(t.HitPos+Vector(0,0,10));
	e:Spawn();
	return e;
end

--################# When removing @JDM12989
function ENT:OnRemove()
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
		timer.Start("block_delay_"..self.ENTINDEX);
		return;
	end

	--self.leader = nil;
	self:AssignLeaders();
	
	if (self.leader == nil) then
		if (not self.timer_run) then
			timer.Start("block_delay_"..self.ENTINDEX);
			self.timer_run = true;
		end
	else
		if (self.timer_run) then
			timer.Stop("block_delay_"..self.ENTINDEX);
			self.timer_run = false;
		end
	end
	
	self:Move();
	local b_s = ents.FindInSphere(self:GetPos(),10);
	local b_n = {};
	for _,v in pairs(b_s) do
		if (v:GetClass() == "block") then
			table.insert(b_n,v);
		end
	end
	if (#b_n >= Replicators.nrq[self.type]) then
		for i=1,#b_n do
			Replicators.Remove(b_n[i]);
			b_n[i]:Remove();
		end
		Msg("spawn replicator!\n");
		local e = ents.Create(self.type);
		e:SetPos(self:GetPos()+Vector(0,0,10));
		e:Spawn();
	end
	
	self:NextThink(CurTime()+1);
end

--################# leader assignment @JDM12989
function ENT:AssignLeaders()
	local pos = self:GetPos();
	local b_s = ents.FindInSphere(pos,self.dist);
	local b_n = {};
	for _,w in pairs(b_s) do
		if (w:GetClass() == "block" and w.leader == nil) then
			table.insert(b_n,w);
		end
	end
	if (#b_n >= Replicators.nrq[self.type]) then
		for _,w in pairs (b_n) do
			w.leader = self;
		end
	end
end

--################# movement @JDM12989
function ENT:Move()
	if (self.leader == nil or not ValidEntity(self.leader)) then return end;
	local vec = self.leader:GetPos()-self:GetPos();
	local dis = vec:Length();
	if (dis > 10) then
		vec = vec:Normalize()*50;
		self:GetPhysicsObject():ApplyForceCenter(vec);
	end
end
