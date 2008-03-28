AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include('shared.lua');
  
function ENT:OnTakeDamage(dmg)
	local att = dmg:GetAttacker();
	local dam = dmg:GetDamage();
	if (dmg:IsExplosionDamage() and dam > 100) then
		self:Remove();
		self:GroupDisband();
	end
	self.attack = att;
end
  
function ENT:SelectSchedule()
	-- leader attacks, organize collective
	if(#attack_list > 0) then
		self:StartSchedule(self:Move(self:Find("player")));
	end
end
