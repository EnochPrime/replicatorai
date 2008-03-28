group = {};
amt = 10;

function ENT:Check()
	if (#group < amt) then
		local req = amt - #group;
		self:AddParty(req);
	end
end

function ENT:AddParty(req)
	local temp = nil;
	local num = #rep_list / 10;
	-- change number to add if requested amount is more than total avaiable
	if (req <= num) then
		num = req;
	end
	-- add to group and remove from available
	for var = 1, num, 1 do
		temp = rep_list[1];
		temp.leader = self;
		table.insert(group,temp);
		self:RemoveRep(temp);
	end
end

function ENT:GroupDisband()
	for var = 1, #group, 1 do
		group[var].leader = nil;
		self:AddRep(group[var]);
	end
end
