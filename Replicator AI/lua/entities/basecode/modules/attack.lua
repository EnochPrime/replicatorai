attack_list = {};

function ENT:AddAttacker(ent)
	if(#attack_list == 0) then
		table.insert(attack_list,ent);
	else
		for k,v in pairs(attack_list) do
			if(v ~= ent) then
				table.insert(attack_list,ent);
			end
		end
	end
end

function ENT:RemoveAttacker(ent)
	self.attack = nil;
	for k,v in pairs(attack_list) do
		if(v == ent) then
			table.remove(attack_list,k);
		end
	end
end

function ENT:AttackCode()
	if (self.leader == nil) then
		if (#attack_list > 0) then
			local att = 0;
			for _,v in pairs(rep_avail) do
				att = attack_list[math.random(1,#attack_list)];
				if (att:IsValid() and att:Alive()) then
					v.attack = att;
				else
					self:RemoveAttacker(att);
				end
			end
		else
			for _,v in pairs(rep_avail) do
				v.attack = nil;
			end
		end
	else
		if (#attack_list > 0) then
			local tbl = self.leader.group;
			for _,v in pairs(tbl) do
				v.attack = self.leader.attack;
			end
		else
			for _,v in pairs(tbl) do
				v.attack = nil;
			end
			self.leader.attack = nil;
		end
	end
end
