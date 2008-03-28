AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include('shared.lua');
  
function ENT:OnTakeDamage(dmg)
	local att = dmg:GetAttacker();
	local dam = dmg:GetDamage();
	self:AddAttacker(att);
	if (self.leader ~= nil) then
		self.leader.attack = att;
	end
	self:SetHealth(self:Health() - dam);
	if (self:Health() <= 0) then
		-- half the blocks if shot or explosion under 100 damage or crossbow which = 100
		-- otherwise it is completely destroyed
		if (dmg:IsBulletDamage() or (dmg:IsExplosionDamage() and dam < 100) or dam == 100) then
			local tbl = self:SpawnX(self.cost,"block");
			self:FadeX(self.cost/2,tbl);
		else
			self:SpawnX(self.cost,"block","npc_rep_n");
		end
		--timer.Simple(0.05,
		--	function()
				self:Remove();
		--	end
		--);
	end
end

-- removes self from the group of its leader if a leader exists
function ENT:OnRemove()
	local temp = self.leader;
	if (temp ~= nil) then
		for k,v in pairs(temp.group) do
			if (v == self) then
				table.remove(temp.group,k);
			end
		end
	end
	self:RemoveRep();
	if (#rep_list == 0) then
		attack_list = {};
	end
end

function ENT:SelectSchedule()
	self:evolve();					-- check if a new form should be created
	self:AttackCode();				-- sets self.attack to a player to be attacked
	if (self.attack ~= nil) then	-- if there is a target, attack it
		self:StartSchedule(self:Move(self.attack));
	-- if there is no leader then collect materials unless they have achieved the limit
	elseif (self.leader == nil or !self.leader:IsValid()) then
		if (self.limit == -1 or self.limit > #rep_list) then
			self:StartSchedule(self:Move(self:Find("prop_physics")));
		else
			self:StartSchedule(self:Move());
		end
	else
		return;
	end
end
