include('spawner.lua');
local immune = StarGate.CFG:Get("replicator","immune",true);
re_freq = {};
im_freq = {};

function ENT:arg(att,freq)
	self:AddAttacker(att);
	if(self.leader ~= nil) then
		self.leader.attack = att;
	end
	if (!immune or self:predict(freq)) then
		local tbl = self:SpawnX(self.cost,"block");
		self:FadeX(self.cost,tbl);
		self:Remove();
	end
end

-- predicts frequencies to become immune unless disabled
function ENT:predict(freq)
	if (#im_freq > 0) then
		if (table.HasValue(im_freq,freq)) then return false	end
	end
	if (#re_freq == 4) then
		for i = 1, 4, 1 do
			if (re_freq == {i,i,i,i}) then
				table.insert(im_freq,i);
				if (i == freq) then	return false end
			end
		end
		if ((re_freq == {1,2,3,4} or re_freq == {1,4,3,2}) and freq == 1) then return false end
		if ((re_freq == {2,3,4,1} or re_freq == {2,1,4,3}) and freq == 2) then return false end
		if ((re_freq == {3,4,1,2} or re_freq == {3,2,1,4}) and freq == 3) then return false end
		if ((re_freq == {4,1,2,3} or re_freq == {4,3,2,1}) and freq == 4) then return false end
	end
	return true;
end

function ENT:RecentUpdate(freq)
	if (#re_freq == 4) then
		table.remove(re_freq,1);
	end
	table.insert(re_freq,freq);
end
