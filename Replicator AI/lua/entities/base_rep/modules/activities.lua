function ENT:Activity(e)
	local c = e:GetClass();
	if (c == "player") then
		e:TakeDamage(5,self);
	elseif (c == "prop_physics") then
		if (Replicators.CDS) then
			cds_damagepos(e,10,0,nil,self);
		elseif (Replicators.GC) then
			gcombat.devhit(e,10);
		else
			timer.Simple(3,
				function()
					e:Remove();
				end
			);
		end
		self.materials = self.materials + 10;
	elseif (c == "rep_q") then
		e.materials = e.materials + self.materials;
		self.materials = 0;
	else
		return;
	end
end
