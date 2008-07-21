-- upload button
function Rep_Upload(p)
	local RC = p.RepController;
	RC.Ent:SetCode("test");
	RC.Ent:SetSchedule(SCHED_NONE);
end
concommand.Add("Rep_Upload",Rep_Upload);

-- freeze button
function Rep_Freeze(p)
	local RC = p.RepController;
	RC.Ent.freeze = not RC.Ent.freeze;
	if (RC.Ent.freeze) then
		RC.Ent:SetSchedule(SCHED_NONE);
	end
end
concommand.Add("Rep_Freeze",Rep_Freeze);

-- reset button
function Rep_Reset(p)
	local RC = p.RepController;
	--RC.Ent:SetCode("base_ai");
	RC.Ent:SetCode("test_ai");
end
concommand.Add("Rep_Reset",Rep_Reset);

-- disassemble button
function Rep_Disassemble(p)
	local RC = p.RepController;
	RC.Ent:Rep_AI_Disassemble();
end
concommand.Add("Rep_Disassemble",Rep_Disassemble);