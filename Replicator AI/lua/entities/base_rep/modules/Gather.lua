-- goes after and gathers materials until reached max_num
-- return true	prop to gather from
-- return false	no prop to gather from
function ENT:Rep_AI_Gather(max_num)
	max_num = max_num or 100;
	local material_metal = self:GetResource("material_metal");
	local material_other = self:GetResource("material_other");
	
	local e = nil;
	if (material_metal + material_other < max_num) then
		e = self:Find("prop_physics");
	else
		e = self:Find("rep_q");
	end
	self.tasks = self:Rep_AI_Follow(e,true);
end

local Data = {
	"Set amount to gather.",
	"numbers",
};

Replicators.RegisterVGUI("Gather",Data);