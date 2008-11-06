--################# HEADER #################
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

--################# SENT CODE #################

--################# Init @JDM12989
function ENT:Initialize()
	self.BaseClass.Initialize(self);
	self.leader = self:Find("rep_q");
end

--################# Select Schedule @JDM12989
function ENT:SelectSchedule()
	if (self.freeze) then return end;
	
	self.attack = self:AttackWho();
	self.tasks = false;
	local i = 1;
	local code = self:GetCode();
	while (not self.tasks and i < #code) do
		local s = code[i];
		RunString(s);
		i = i + 1;
	end
end
