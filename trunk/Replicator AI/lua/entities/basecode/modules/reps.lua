rep_list = {};
rep_avail = {};

function ENT:AddRep()
	table.insert(rep_list,self);
	if (self:GetClass() == "npc_rep_n") then
		self:SetAvail(self,true);
	end
end

function ENT:RemoveRep()
	Msg("remove rep\n");
	for k,v in pairs(rep_list) do
		if (v == self) then
			table.remove(rep_list,k);
			v:SetAvail(self,false);
		end
	end
	Msg("table = " .. #rep_list .. "\n");
end

function ENT:SetAvail(ent,bool)
	if(bool) then
		table.insert(rep_avail,ent);
		ent.leader = nil;
	else
		for k,v in pairs(rep_avail) do
			if (v == ent) then
				table.remove(rep_avail,k);
			end
		end
	end
end
