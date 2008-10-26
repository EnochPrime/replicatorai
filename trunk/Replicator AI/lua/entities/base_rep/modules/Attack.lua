function ENT:AttackWho()
	return Replicators.Attackers[1];
end

-- make rep attack specific enemy
-- return true	ent to attack
-- return false	no ent to attack
function ENT:Rep_AI_Attack(e)
	self:Rep_AI_Follow(e,true);
end

local Data = {
	"Choose what to attack.",
	"ents",
};

Replicators.RegisterVGUI("Attack",Data);
