function ENT:SpawnX(num,ent)
	if (num <= 0) then return end
	local tbl = {};
	for var = 1, num, 1 do
		local newReplicator = ents.Create(ent);
		newReplicator:SetPos(self:GetPos()+(self:GetUp()*1));
		newReplicator:Spawn();
		newReplicator:Activate();
		table.insert(tbl,newReplicator);
	end
	return tbl;
end
