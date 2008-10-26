--################# HEADER #################
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

--################# SENT CODE #################

--################# Init @JDM12989
function ENT:Initialize()
	self.BaseClass.Initialize(self);
end

--################# Select Schedule @JDM12989
function ENT:SelectSchedule()
	if (self.freeze) then return end;
	-- if low numbers then resort to the start up code
--	if (table.Count(Replicators.Reps) <= 1) then
--		self.BaseClass.SelectSchedule();
--	else
		self.attack = self:AttackWho();
		self.tasks = false;
		local i = 1;
		local code = self:GetCode();
		while (not self.tasks and i < #code) do
			local s = code[i];
			RunString(s);
			i = i + 1;
		end
--	end
end
