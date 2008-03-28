include('attack.lua');
include('spawner.lua');

--################# Activity @JDM12989
-- what is done when replicator is near target object?
-- player = hurt with 1 dmg
-- prop = GCombat damage until destroyed and gather material for replication
-- shield = disable shield, reactivate with max size and strength (large rep only)
function ENT:Activity(ent)
	local c = ent:GetClass();
	if (c == "player") then
		ent:TakeDamage(1,self);
	elseif (c == "prop_physics") then
		-- makes an explosion at the end, fix later
		-- implement avon's damage code eventually
		if (gcombat) then
			gcombat.devhit(ent,10,20,true);
		else
			ent:Remove();
		end
		self.mat = self.mat + 10;
		if (self.mat >= 100) then
			self:SpawnX(1,"npc_rep_n");
			self.mat = self.mat - 100;
		end
	elseif (c == "shield_generator") then
		RD_SupplyResource(self, "energy", 100000000); -- large amount to insure the shield won't collapes, will probably change later
		if (!self.shield) then
			self.shield = true;
			ent:TriggerInput("Activate",0);
			if (self:GetClass() == "npc_rep_l") then
				self:AutoLink(self,ent);
				ent:SetMultiplier(5);
				ent:TriggerInput("Activate",1);
			else
				self.shield = false;
			end
		end
	else
		return;
	end
end

--################# AutoLink @aVoN
-- from stargate_base_tool.lua
function ENT:AutoLink(e1,e2)
	-- Is resource distribution installed?
	if(Dev_Link and e1 and e2 and e1:IsValid() and e2:IsValid() and e1 ~= e2) then
		-- First is for RD1, second for RD2
		local e1_res = e1.resources or e1.resources2;
		local e2_res = e2.resources or e2.resources2;
		if(e1_res and e2_res) then
			-- Devices needs that power?
			local match = false;
			for _,res1 in pairs(e1_res) do
				for _,res2 in pairs(e2_res) do
					if (res1.res_ID == res2.res_ID) then
						match = true;
						break;
					end
				end
				if(match) then break end;
			end
			if(not match) then return end;
			-- Devide already linked with that (Normally not, but just to be sure)?
			for _,res in pairs(e1_res) do
				for _,v in pairs(res.links) do
					if (e2 == v.ent) then
						return;
					end
				end
			end
			-- Create an invisible link
			Dev_Link(e1,e2,e1:GetPos(),e2:GetPos(),"cable/cable2",Color(0,0,0,0),0);
		end
	end
end
