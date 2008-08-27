Replicators.RD = {};

function Replicators.AddRDSupport(ENT)
	ENT.HasRD = Replicators.RD;
	
	ENT.AddResource = Replicators.RD.AddResource;
	ENT.GetResource = Replicators.RD.GetResource;
	ENT.ConsumeResource = Replicators.RD.ConsumeResource;
	ENT.SupplyResource = Replicators.RD.SupplyResource;
	ENT.Link = Replicators.RD.Link;
end

function Replicators.RD.AddResource(self,resource,maximum,default)
	if (self.HasRD) then
		if (CAF and CAF.GetAddon("Resource Distribution")) then
			CAF.GetAddon("Resource Distribution").AddResource(self,resource,maximum,default or 0);
		else
			RD_AddResource(self,resource,maximum or 0);
		end
	end
end

function Replicators.RD.GetResource(self,resource,default)
	if (self.HasRD) then
		if (CAF and CAF.GetAddon("Resource Distribution")) then
			return CAF.GetAddon("Resource Distribution").GetResourceAmount(self,resource) or default or 0;
		else
			return RD_GetResourceAmount(self,resource) or default or 0;
		end
	end
end

function Replicators.RD.ConsumeResource(self,resource,amount)
	if (self.HasRD) then
		if (CAF and CAF.GetAddon("Resource Distribution")) then
			CAF.GetAddon("Resource Distribution").ConsumeResource(self,resource,amount or 0);
		else
			RD_ConsumeResource(self,resource,amount or 0);
		end
	end
end

function Replicators.RD.SupplyResource(self,resource,amount)
	if (self.HasRD) then
		if (CAF and CAF.GetAddon("Resource Distribution")) then
			CAF.GetAddon("Resource Distribution").SupplyResource(self,resource,amount or 0);
		else
			RD_SupplyResource(self,resource,amount or 0);
		end
	end
end

function Replicators.RD.Link(self,node)
	if (self.HasRD and ValidEntity(self) and ValidEntity(node)) then
		if (CAF and CAF.GetAddon("Resource Distribution")) then
			CAF.GetAddon("Resource Distribution").Link(self,node.netid);
		else
			Dev_Link(self,node,self:GetPos(),node:GetPos(),"cable/cable2",Color(0,0,0,0),0);
		end
	end
end
