--################# HEADER #################
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

--################# SENT CODE #################

--################# Init @JDM12989
function ENT:Initialize()
	self.BaseClass.Initialize(self);
	self.max_materials = 100;
end

--################# Select Schedule @JDM12989
function ENT:SelectSchedule()
	if (self.freeze) then return end;
	-- if low numbers then resort to the start up code
--	if (#Replicators.Reps <= 1) then
--		self.BaseClass.SelectSchedule();
--	else
		self.attack = self:AttackWho();
		self.tasks = false;
		local i = 1;
		while (not self.tasks and i < #self.code) do
			local s = self.code[i];
			RunString(s);
			i = i + 1;
		end
--	end
end
