AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include('shared.lua');
include('modules/group.lua');

function ENT:OnTakeDamage(dmg)
	local att = dmg:GetAttacker();
	local dam = dmg:GetDamage();
	self:AddAttacker(att);
	if (self.leader ~= nil) then
		self.leader.attack = att;
	end
	self:SetHealth(self:Health() - dam);
	if (self:Health() <= 0) then
		self:Remove();
		-- half the blocks if shot or explosion under 100 damage or crossbow which = 100
		-- otherwise it is completely destroyed
		if (dmg:IsBulletDamage() or (dmg:IsExplosionDamage() and dam < 100) or dam == 100) then
			self:SpawnX(self.cost/2,"block","npc_rep_n");
		end
		self:GroupDisband();
	end
end

function ENT:OnRemove()
	for var = 1, #group, 1 do
		self:SetAvail(group[var],true);
	end
	self:RemoveRep();
end

function ENT:SelectSchedule()
	local dist = 0;
	local ent = self:Find("shield_generator");
	if (ent ~= nil and ent:IsValid() and ent:Enabled()) then
		dist = ent.Shield.Size + 50;
		for _,v in pairs(group) do
			v:StartSchedule(self:Move(self:Find("shield_generator"),50));
		end
	end
	self:StartSchedule(self:Move(ent,dist));
end

function ENT:Think()
	-- gather a group of replicators to follow
	self:Check();
	-- make all replicators in group follow
	-- put this in the SelectSchedule of npc_rep_n
	for var = 1, #group, 1 do
		if (group[var] ~= nil and group[var]:IsValid()) then
			group[var]:StartSchedule(self:Move(self,75));
		end
	end
end
