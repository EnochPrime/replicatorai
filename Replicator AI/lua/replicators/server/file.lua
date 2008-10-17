--############### Create new dir on server @JDM12989
function Replicators.CreateDir(p,com,args)
	file.CreateDir(args[1]);
end
concommand.Add("RepCreateDir",Replicators.CreateDir);

--############### Send string dir/code to client @JDM12989
function Replicators.ReturnString(p,com,args)
	local s = "";
	if (args[1] == "DIR") then
		local files = file.Find(args[2].."*");
		for _,fn in pairs(files) do
			s = s..fn..",";
		end
		umsg.Start("RepSendDirData");
	elseif (args[1] == "CODE") then
		s = file.Read(args[2]);
		umsg.Start("RepSendLoadData");
	else
		return;
	end
	umsg.String(args[2]);
	umsg.String(s);
	umsg.End();
end
concommand.Add("RepReturnString",Replicators.ReturnString);

--############### Saves file to server @JDM12989
function Replicators.SaveFile(p,com,args)
	if (not args[3] or args[3] == "") then return end;
	file.Write(args[1]..args[2],args[3]);
end
concommand.Add("RepSaveFile",Replicators.SaveFile);

--############### Creates the player's dir on server @JDM12989
function Replicators.InitDirectory(p)
	if (p and p:IsValid() and p:IsPlayer()) then
		if (#file.FindDir("replicators/"..p:GetName()) == 0) then
			file.CreateDir("replicators/"..p:GetName());
		end
	end
end
concommand.Add("RepInitUserDir",Replicators.InitDirectory);