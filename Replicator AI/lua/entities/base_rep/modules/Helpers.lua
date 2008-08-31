-- does appropriate activity based on the entitiy
function ENT:Activity(e)
	local c = e:GetClass();
	if (c == "rep_q") then
		local material_metal = self:GetResource("material_metal");
		local material_other = self:GetResource("material_other");
		e:SupplyResource("material_metal",material_metal);
		e:SupplyResource("material_other",material_other);
		self:ConsumeResource("material_metal",material_metal);
		self:ConsumeResource("material_other",material_other);
	end
	
	if (e:IsPlayer() or e:IsNPC()) then
		e:TakeDamage(5,self);
	elseif (c == "prop_physics") then
		if (gcombat) then
			if (gcombat.devhit(e,10,4) == 2) then
				e:Remove();
			end
		elseif (cds_damagepos) then
			cds_damagepos(e,10,50,nil,self);
		else
			timer.Create("prop_"..e:EntIndex(),3,1,
				function()
					e:Remove();
				end
			);
		end
		self:SupplyResource("material_metal",10);
	elseif (c == "Zero_Point_Module") then
		self:Link(self,e);
	end
end

-- extracts entity from table of strings
-- return ent
function ENT:ExtractEnt(t)
	if (type(t) == "table") then
		local ents = ents.GetAll();
		local ent_table = {};
		local ent_trgt = ent_trgt or nil;
		
		-- setup of ent_table
		for _,v in pairs(ents) do
			if (v:IsPlayer()) then
				ent_table[v:GetName()] = v;
			elseif (v:IsNPC()) then
				ent_table[v:GetClass()] = v;
			end
		end
		-- find 1st valid and set as target
		for k,v in pairs(ent_table) do
			if (not p_trgt and table.HasValue(t,k) and ValidEntity(v)) then
				p_trgt = v;
				t = p_trgt;
			end
		end
	end
	-- last resort in case the table is not chaged to a player or npc
	if (type(t) == "table") then
		t = nil;
	end
	return t;
end

-- finds the nearest object by it's class
-- return closest ent by class
function ENT:Find(s)
	local e = nil;
	local color = {};
	local d = 5000;
	local dist = 0;
	local pos = self:GetPos();
	for _,v in pairs(ents.FindInSphere(pos,d)) do
		color = {v:GetColor()};
		if (v:GetClass() == s and color[4] == 255 and not table.HasValue(Replicators.IgnoreMe,v:GetModel())) then
			dist = (pos - v:GetPos()):Length();
			if (dist < d) then
				d = dist;
				e = v;
			end
		end
	end
	return e;
end
