blocks = {};

function ENT:AddBlock()
	table.insert(blocks,self);
end

function ENT:RemoveBlock()
	for k,v in pairs(blocks) do
		if (v == self) then
			table.remove(blocks,k);
		end
	end
	Msg("table = " .. #blocks .. "\n");
end

function ENT:Check()
	local b = true;
	for k,v in pairs(blocks) do
		if (v.leader == nil) then
			v.leader = blocks[1];
		else
			b = false;
		end
	end
	if (b and blocks[1] ~= nil) then
		blocks[1].leader = blocks[1];
	end
end
