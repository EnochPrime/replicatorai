Msg("\n===========================");
Msg("\n== Replicators Installed ==");
Msg("\n===========================\n");

local Category = "Replicators"

local NPC = { 	Name = "Replicator", 
				Class = "npc_rep_n",
				Category = Category	}

list.Set( "NPC", NPC.Class, NPC )

local NPC = {	Name = "Large Rep",
				Class = "npc_rep_l",
				Category = Category }
				
list.Set( "NPC", NPC.Class, NPC )

local NPC = {	Name = "Human-Form Rep",
				Class = "npc_rep_h",
				Category = Category }
				
list.Set( "NPC", NPC.Class, NPC )
