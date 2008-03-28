language.Add("npc_rep","Replicator");

-- Kill Icon
if(file.Exists("../materials/npc/rep_killicon.vmt")) then
	killicon.Add("npc_rep","npc/rep_killicon",Color(255,255,255));
	killicon.Add("npc_rep_l","npc/rep_killicon",Color(255,255,255));
	killicon.Add("npc_rep_h","npc/rep_killicon",Color(255,255,255));
end
