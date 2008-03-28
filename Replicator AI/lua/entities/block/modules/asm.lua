include('spawner.lua');
local b_c, b_n, d, d_max, pos;
local cost = {StarGate.CFG:Get("replicator","costn"),StarGate.CFG:Get("replicator","costl"),StarGate.CFG:Get("replicator","costh")};

function ENT:Assemble()
	if (self.assembled) then return end
	if (self.class == "npc_rep_n") then
		self.cost = cost[1];
	elseif (self.class == "npc_rep_l") then
		self.cost = cost[2];
	elseif (self.class == "npc_rep_h") then
		self.cost = cost[3];
	else
		return;
	end
	pos = self:GetPos();
	d_max = 20;
	b_n = ents.FindInSphere(pos,d_max);
	b_c = {};
	if (b_n == nil or #b_n == 0) then return end
	for _,v in pairs(b_n) do
		if (v:GetClass() == "block" and not v.sever) then
			d = (v:GetPos()-pos):Length();
			if (d < d_max) then
				table.insert(b_c,v);
			end
		end
	end
	if (b_c == nil or #b_c < self.cost) then return end
	if (self.leader ~= self) then return end
	self.assembled = true;
	timer.Simple(self.cost*0.04,
		function()
			for i = 1, self.cost, 1 do
				b_c[i]:Remove();
				if (i == self.cost) then
					self:SpawnX(1,self.class);
				end
			end
		end
	);
end

-- take me to your leader
function ENT:Gather()
	if (self.leader == nil or not self.leader:IsValid()) then return end
	pos = self:GetPos();
	d = self.leader:GetPos() - pos;
	if (d:Length() > 10) then
		local vec = d:Normalize()*50;
		self:GetPhysicsObject():ApplyForceCenter(vec);
		return true;
	end
	return false;
end
