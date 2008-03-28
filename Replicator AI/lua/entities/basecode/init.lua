AddCSLuaFile("shared.lua");
include('shared.lua');
include('modules/act.lua');
include('modules/arg.lua');
include('modules/attack.lua');
include('modules/evolve.lua');
include('modules/move.lua');
include('modules/reps.lua');
include('modules/spawner.lua');

function ENT:Initialize()
	self:SetModel(self.model);
	self:SetHullType(self.hull);
	self:SetHullSizeNormal();
	self:SetSolid(SOLID_BBOX);
	self:SetMoveType(MOVETYPE_STEP);
	self:CapabilitiesAdd(CAP_MOVE_GROUND);
	self:SetMaxYawSpeed(5000);
	self:SetHealth(self.health);
	self:AddRep();
	self.attack = nil;
	self.leader = nil;
	self.limit = StarGate.CFG:Get("replicator","limit");
	self.mat = 0;
	self.override = true;
	self.shield = false;
	--if (LS_RegisterEnt) then LS_RegisterEnt(self) end
	if (StarGate.HasResourceDistribution) then
		RD_AddResource(self, "energy", 100000000);
	end
end
