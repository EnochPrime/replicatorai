-- this code will also be used on the human-form
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
	local num = #rep_avail / 10;
	-- change number to add if requested amount is more than total avaiable
	if (req <= num) then
		num = req;
	end
	-- add to group and remove from available
	for var = 1, num, 1 do
		temp = rep_avail[1];
		temp.leader = self;
		table.insert(group,temp);
		self:SetAvail(temp,false);
	end
end
