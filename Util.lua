local addonPrefix = "WS_INT_ROTATION"

local function StripRealm(unit)
	local hyphenPos = string.find(unit, "-")
	
	if hyphenPos then
		return string.sub(unit, 1, hyphenPos - 1)
	else
		return unit
	end
end

local function AddRealm(unit)
	local hasRealm = string.find(unit, "-")
	
	if hasRealm then
		return unit
	else
		return unit .. "-" .. GetRealmName()
	end
end

local function GetPetOwner(pet)
	local group = IsInRaid() and "raid" or "party"
	
	if group == "party" then
		if UnitGUID("pet") == pet then
			return UnitName("player")
		end
	end
	
	local numMembers = GetNumGroupMembers()
	for i = 1, numMembers do
		local unit = group .. i
		if UnitGUID(unit .. "-pet") == pet then
			local name, realm = UnitName(unit)
			if realm then
				name = name .. "-" .. realm
			end
			
			return name or pet
		end
	end
	return pet
end

local debugEnabled = true
local function printdebug(str)
	if debugEnabled then
		print(str)
	end
end