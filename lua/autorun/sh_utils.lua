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

function eye()
	if SERVER then
		return player.GetAll()[1]:GetEyeTrace()
	else
		return LocalPlayer():GetEyeTrace()
	end
end

function this()
	return eye().Entity
end

if SERVER then
	function showConstraints()
		local Ent = this()

		if IsValid(Ent) then
			for _, V in pairs(Ent.Constraints) do
				local Ent1 = V.Ent1
				local Ent2 = V.Ent2

				if IsValid(Ent1) and IsValid(Ent2) then
					local L = V.LPos1 and Ent1:LocalToWorld(V.LPos1) or Ent1:GetPos()
					local R = V.LPos2 and Ent2:LocalToWorld(V.LPos2) or Ent2:GetPos()

					debugoverlay.Line(L, R, 10, Color(0, 255, 0), true)
					debugoverlay.Text((L+R)*0.5, V.Type, 10, false)
				end
			end

			if IsValid(Ent:GetParent()) then
				local Parent = Ent:GetParent()

				local L = Ent:GetPos()
				local R = Parent:GetPos()

				debugoverlay.Line(L, R, 10, Color(255, 255, 0), true)
				debugoverlay.Text(L, "Parented", 10, false)
			end
		end
	end
end