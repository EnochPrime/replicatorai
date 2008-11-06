--################# Register resources for client download @JDM12989
function Replicators.ResDownload()
	local str = {
		materials1 = "addons/Replicator AI/materials/JDM12989/",
		materials2 = "addons/Replicator AI/materials/JDM12989/Rep_Creator/",
		materials3 = "addons/Replicator AI/materials/JDM12989/Replicators/",
		materials4 = "addons/Replicator AI/materials/VGUI/entities/",
		materials5 = "addons/Replicator AI/materials/Votekick/",
		materials6 = "addons/Replicator AI/materials/weapons/",
		
		models1 = "addons/Replicator AI/models/JDM12989/Replicators/",
		models2 = "addons/Replicator AI/models/JDM12989/Replicators/Rep_N",
		models3 = "addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/",
		models4 = "addons/Replicator AI/models/Votekick/",
		
		sounds1 = "addons/Replicator AI/sound/Replicators/",
	};
	
	for _,v in pairs(str) do
		for _,fn in pairs(file.Find("../"..v.."*.*")) do
			resource.AddFile(v..fn);
		end
	end
end
Replicators.ResDownload();