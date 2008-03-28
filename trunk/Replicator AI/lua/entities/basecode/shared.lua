ENT.Base = "base_ai"
ENT.Type = "ai"
 
ENT.PrintName = "Replicator Base Code"
ENT.Author = "JDM12989"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = StarGate.CFG:Get("replicator","spawnable");
ENT.AdminSpawnable = StarGate.CFG:Get("replicator","admin");
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim;
end 