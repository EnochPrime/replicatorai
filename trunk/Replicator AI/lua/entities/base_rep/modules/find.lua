function ENT:Find(c)
	local e = nil;
	local color = {};
	local d = 5000;
	local dis = 0;
	local pos = self:GetPos();
	for _,v in pairs(ents.FindInSphere(pos,d)) do
		color = {v:GetColor()};
		if (v:GetClass() == c and color[4] == 255) then
			dis = (pos - v:GetPos()):Length();
			if (dis < d) then
				d = dis;
				e = v;
			end
		end
	end
	return e;
end
