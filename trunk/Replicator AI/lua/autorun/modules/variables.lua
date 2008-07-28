-- list of attackers
Replicators.Attackers = {};

-- list of blocks
Replicators.Blocks = {};

-- list of replicators
Replicators.Reps = {};

-- maximum number of replicators
Replicators.Limit = 25;

-- required blocks for types
Replicators.RequiredNumber = {};
	Replicators.RequiredNumber["rep_n"] = 20;
	Replicators.RequiredNumber["rep_q"] = 50;
	
-- booleans for other addons
Replicators.RD = Dev_Link or #file.FindInLua("weapons/gmod_tool/stools/dev_link.lua") == 1;
Replicators.CD = #file.FindInLua("autorun/server/sv_cds_core.lua") == 1;
Replicators.GC = #file.FindInLua("weapons/gmod_tool/stools/gcombat.lua") == 1;
Replicators.SG = #file.FindInLua("autorun/stargate.lua") == 1;

-- find precendence & model ignore lists
Replicators.FindMe = {"prop_physics"};
Replicators.IgnoreMe = {
	"models/Zup/ramps/brick_01.mdl",
	"models/Zup/ramps/brick_01_small.mdl",
	"models/Zup/ramps/sgc_ramp.mdl",
	"models/Zup/ramps/sgc_ramp_small.mdl"
};