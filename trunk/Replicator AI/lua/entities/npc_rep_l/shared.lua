ENT.Base = "basecode"
ENT.Type = "ai"
 
ENT.PrintName = "Large Replicator"
ENT.Author = "JDM12989"
ENT.Contact = "" --fill in these if you want it to be in the spawn menu
ENT.Purpose = "Advance Technology"
ENT.Instructions = ""
 
ENT.AutomaticFrameAdvance = true
ENT.model = "models/antlion.mdl";
ENT.hull = HULL_MEDIUM;
ENT.health = 200;
ENT.cost = 40;
ENT.spread = 500;

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
 
 self.AutomaticFrameAdvance = bUsingAnim
 
end 