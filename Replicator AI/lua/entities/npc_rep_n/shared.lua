ENT.Base = "basecode"
ENT.Type = "ai"
 
ENT.PrintName = "Standard Replicator"
ENT.Author = "JDM12989"
ENT.Contact = ""
ENT.Purpose = "Self Replication"
ENT.Instructions = ""
 
ENT.AutomaticFrameAdvance = true
ENT.model = "models/headcrab.mdl";
--ENT.model = "models/JDM12989/Replicators/Rep_N.mdl";
ENT.hull = HULL_TINY;
ENT.health = 25;
ENT.cost = 20;
ENT.spread = 100

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim;
end 