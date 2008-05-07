function ENT:Activity(e)
	local c = e:GetClass();
	if (c == "player") then
		e:TakeDamage(5,self);
	elseif (c == "prop_physics") then
		if (gcombat) then
			MsgN("gcombat damage");
			if (gcombat.devhit(e,10,4) == 2) then
				e:Remove();
			end
		elseif (cds_damagepos) then
			cds_damagepos(e,10,50,nil,self);
		else
			MsgN("no sys damage");
			timer.Create("prop_"..e:EntIndex(),3,1,
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
