-- this code is used to control the evolution from one form to another
local iCreate = StarGate.CFG:Get("replicator","evolve",false);
local cost = {StarGate.CFG:Get("replicator","costn",10),StarGate.CFG:Get("replicator","costl",50),StarGate.CFG:Get("replicator","costh",30)};
local c_l = cost[2]/cost[1];
local c_h = cost[3]/cost[1];
local count, tbl, b, l;
local bool = true; -- so too many don't fall apart

function ENT:evolve()
	if not(iCreate or bool) then return end
	local class = self:GetClass();
	if (class == "npc_rep_n") then
		--if (#rep_list == c_l) then -- temporary for testing purposes, official line below
		if (#rep_list > (c_l + 10) and self:Find("shield_generator") ~= nil and not self:exist("npc_rep_l")) then
			bool = false;
			count = c_l;
			b = true;
			for i = count, 1, -1 do
				if (rep_list[i]:GetClass() == "npc_rep_n") then
					local temp = rep_list[i];
					tbl = temp:SpawnX(cost[1],"block","npc_rep_l");
					temp:RemoveRep();
					temp:Remove();
				end
				if (b) then
					b = false;
					l = tbl[1];
				end
			end
		end
		--[[
		if (#rep_list > (c_h + 10) and #attack_list > 0 and not self:exist("npc_rep_h")) then
			bool = false;
			count = c_h;
			b = true;
			for i = count, 1, -1 do
				if (rep_list[i]:GetClass() == "npc_rep_n") then
					local temp = rep_list[i];
					tbl = temp:SpawnX(cost[1],"block","npc_rep_h");
					temp:RemoveRep();
					temp:Remove();
				end
				if (b) then
					b = false;
					l = tbl[1];
				end
			end
		end]]
	end
	
	if (class == "npc_rep_l") then
		if (#rep_list < (c_l + 10) or self:Find("shield_generator") == nil) then
			-- disassemble large rep
			self:SpawnX(cost[2],"block","npc_rep_n");
			self:Remove();
		end
	end
--[[ disassembling of human-form disabled for now
	if (class == "npc_rep_h") then
		if (#rep_list < (c_h +10) or #attack_list == 0) then
			-- disassemble human rep
			self:SpawnX(cost[3],"block","npc_rep_n");
		end
	end]]
	bool = true;
end

function ENT:exist(class)
	local vclass;
	for k,v in pairs(rep_list) do
		vclass = v:GetClass();
		if (vclass == class) then
			return true;
		end
	end
	return false;
end
