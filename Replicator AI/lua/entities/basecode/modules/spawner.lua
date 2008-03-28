function ENT:SpawnX(num,class,make)
	local tbl = {};
	num = math.max(1,num);
	local i;
	local pos = self:GetPos();
	local pup = self:GetUp();
	for i = 1, num do
		local a, b, x, y;
		timer.Simple((i-1)*0.01,
			function()
				a = ents.Create(class);
				b = pos;
				if (math.random(0,1) == 1) then
					x = math.random(400)/10;
				else
					x = (-1) * math.random(400)/10;
				end
				if (math.random(0,1) == 1) then
					y = math.random(400)/10;
				else
					y = (-1) * math.random(400)/10;
				end
				b = b + Vector(x,y,pup*5);
				a:SetPos(b);
				a:Spawn();
				a:Activate();
				table.insert(tbl,a);
				if (make == nil) then
					a.class = "npc_rep_n";
				else
					a.class = make;
				end
			end
		);
	end
	return tbl;
end

function ENT:FadeX(num,tbl)
	if (num <= 0) then return end
	for var = 1, num, 1 do
		timer.Simple((var-1)*0.02,
			function()
				tbl[var].sever = true;
				tbl[var]:OnRemove();
			end
		);
	end
end
