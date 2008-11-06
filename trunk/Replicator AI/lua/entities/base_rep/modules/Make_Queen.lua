function ENT:Rep_AI_Make_Queen()
	if (not self.leader or not ValidEntity(self.leader)) then
		local rep_energy = self:GetResource("rep_energy");
		rep_energy = 1000;
		-- form queen or gather more material & energy
		if (rep_energy >= 1000 and self.material_metal >= 3000) then
			self:ConsumeResource("rep_energy",1000);
			self.material_metal = self.material_metal - 1000;
			Replicators.Remove(self);
			self:Remove();
			local e = ents.Create("rep_q");
			e:SetPos(self:GetPos());
			e:SetAngles(self:GetAngles());
			e:Spawn();
			e.material_metal = self.material_metal;
		else
			self:Rep_AI_Gather(3000);
			if (not self.tasks and rep_energy < 1000) then
				self:Rep_AI_Follow(self:Find("Zero_Point_Module"),true);
			elseif (not self.tasks) then
				self:Rep_AI_Wander();
			end
		end	
		self.tasks = true;
	else
		self.tasks = false;
	end
end

local Data = {};

Replicators.RegisterVGUI("Make_Queen",Data);