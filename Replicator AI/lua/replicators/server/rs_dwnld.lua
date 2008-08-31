--################# Register resources for client download @JDM12989
function Replicators.ResDownload()
	local materials = {
		"addons/Replicator AI/materials/Block_Tex.vmt",
		"addons/Replicator AI/materials/Block_Tex.vtf",
		
		"addons/Replicator AI/materials/JDM12989/Block_Tex.vmt",
		"addons/Replicator AI/materials/JDM12989/Block_Tex.vtf",
		
		"addons/Replicator AI/materials/JDM12989/Replicators/Block.vmt",
		"addons/Replicator AI/materials/JDM12989/Replicators/Block.vtf",
		"addons/Replicator AI/materials/JDM12989/Replicators/Block_Gray.vmt",
		"addons/Replicator AI/materials/JDM12989/Replicators/Block_Gray.vtf",
		
		"addons/Replicator AI/materials/VGUI/entities/block.vmt",
		"addons/Replicator AI/materials/VGUI/entities/block.vtf",
		"addons/Replicator AI/materials/VGUI/entities/rep_h.vmt",
		"addons/Replicator AI/materials/VGUI/entities/rep_h.vtf",
		"addons/Replicator AI/materials/VGUI/entities/rep_n.vmt",
		"addons/Replicator AI/materials/VGUI/entities/rep_n.vtf",
		"addons/Replicator AI/materials/VGUI/entities/rep_q.vmt",
		"addons/Replicator AI/materials/VGUI/entities/rep_q.vtf",
		"addons/Replicator AI/materials/VGUI/entities/weapon_arg.vmt",
		"addons/Replicator AI/materials/VGUI/entities/weapon_arg.vtf",
		
		"addons/Replicator AI/materials/weapons/arg_inventory.vmt",
		"addons/Replicator AI/materials/weapons/arg_inventory.vtf",
	};
	
	local models = {
		"addons/Replicator AI/models/JDM12989/Replicators/Block.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Block.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Block.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/block.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Block.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/block.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Block.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Rep_N.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Rep_N.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Rep_N.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/rep_n.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Rep_N.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/rep_n.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Rep_N.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/1.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/1.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/1.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/1.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/1.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/1.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/1.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/2.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/2.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/2.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/2.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/2.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/2.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/2.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/3.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/3.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/3.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/3.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/3.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/3.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/3.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/4.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/4.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/4.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/4.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/4.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/4.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/4.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/5.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/5.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/5.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/5.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/5.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/5.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/5.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/6.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/6.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/6.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/6.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/6.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/6.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/6.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/7.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/7.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/7.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/7.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/7.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/7.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/7.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/8.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/8.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/8.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/8.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/8.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/8.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/8.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/9.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/9.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/9.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/9.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/9.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/9.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/9.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/10.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/10.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/10.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/10.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/10.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/10.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/10.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/11.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/11.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/11.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/11.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/11.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/11.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/11.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/12.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/12.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/12.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/12.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/12.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/12.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/12.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/13.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/13.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/13.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/13.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/13.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/13.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/13.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/14.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/14.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/14.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/14.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/14.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/14.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/14.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/15.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/15.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/15.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/15.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/15.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/15.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/15.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/16.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/16.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/16.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/16.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/16.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/16.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/16.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/17.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/17.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/17.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/17.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/17.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/17.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/17.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/18.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/18.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/18.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/18.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/18.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/18.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/18.xbox.vtx",
		
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/19.phy",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/19.dx80.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/19.dx90.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/19.mdl",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/19.sw.vtx",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/19.vvd",
		"addons/Replicator AI/models/JDM12989/Replicators/Rep_N/Gibs/19.xbox.vtx",
	};
	
	local sounds = {
		"addons/Replicator AI/sound/Replicators/attack.wav",
		"addons/Replicator AI/sound/Replicators/far_inwall.wav",
		"addons/Replicator AI/sound/Replicators/idle.wav",
		"addons/Replicator AI/sound/Replicators/run.wav",
		"addons/Replicator AI/sound/Replicators/run2.wav",
		"addons/Replicator AI/sound/Replicators/walk.wav",
		"addons/Replicator AI/sound/Replicators/walk2.wav",
	};
	
	for _,fn in pairs(materials) do
		resource.AddFile(fn);
	end
	for _,fn in pairs(models) do
		resource.AddFile(fn);
	end
	for _,fn in pairs(sounds) do
		resource.AddFile(fn);
	end
end
Replicators.ResDownload();