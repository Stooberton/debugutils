function Print(...)
	if select("#", ...) == 1	-- only 1 element
		and type(...) == "table"	-- which is a table
		and (getmetatable(...) == nil or not debug.getmetatable(...).__tostring)	-- that has no custom tostring function
	then
		PrintTable(...)
	else
		print(...)
	end
end

if SERVER then
	function Eye()
		local _, Ply = next(player.GetAll())

		return Ply:GetEyeTrace()
	end
else
	function Eye()
		return LocalPlayer():GetEyeTrace()
	end
end