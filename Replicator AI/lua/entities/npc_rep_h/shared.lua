ENT.Base = "basecode"
ENT.Type = "ai"
 
ENT.PrintName = "Humanform Replicator"
ENT.Author = "JDM12989"
ENT.Contact = "" --fill in these if you want it to be in the spawn menu
ENT.Purpose = "Leader"
ENT.Instructions = ""
 
ENT.AutomaticFrameAdvance = true
--ENT.model = "models/humans/group01/male_01.mdl";
ENT.model = "models/gman.mdl";
ENT.hull = HULL_HUMAN;
ENT.health = 1000;
ENT.cost = 80;
ENT.spread = 500;

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
 
 self.AutomaticFrameAdvance = bUsingAnim
 
end 