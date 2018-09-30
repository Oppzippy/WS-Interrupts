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