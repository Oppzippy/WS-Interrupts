local InterruptPriority = {}
InterruptPriority.__index = InterruptPriority

-- Priority table is priority=>unit
local function CreateInterruptPriority(priority, cooldownWatcher)
	local intPriority = {}
	setmetatable(intPriority, InterruptPriority)
	
	-- Constructor
	
	intPriority.cooldownWatcher = cooldownWatcher
	intPriority.basePriority = priority
	intPriority.prevInterrupter = nil
	-- Index both directions for faster lookup
	for i, unit in ipairs(priority) do
		priority[unit] = i
	end
	
	return intPriority
end

-- Indended for finding a unit's priority
function InterruptPriority:GetUnitPriority(unit)
	return self.basePriority[unit]
end

-- Intended for finding a unit at a specific priority
function InterruptPriority:GetUnitByPriority(priority)
	return self.basePriority[priority]
end

function InterruptPriority:IsUnitFree(unit)
	unit = StripRealm(unit)
	
	if UnitIsDeadOrGhost(unit) or not UnitExists(unit) then
		return false
	end
	
	for i = 1, 255 do
		local spellId = select(10, UnitAura(unit, i, "HARMFUL"))
		if spellId and badDebuffs[spellId] then
			return false
		else
			break
		end
	end
	
	return true
end

function InterruptPriority:GetHighestPriority()
	printdebug("gethighestpriority")
	local lowestCdUnit, lowestCdTime, priorityTable
	local cooldownWatcher = self.cooldownWatcher
	-- Cooldown pass
	for priority, unit in ipairs(self.basePriority) do
		local cd = cooldownWatcher:GetCooldown(unit)
		if not cd then -- Off cd
			if not priorityTable then
				priorityTable = {}
			end
			
			local isFree = self:IsUnitFree(unit) -- check for CC
			if isFree then
				table.insert(priorityTable, unit)
			end
		elseif not priorityTable then -- Is on cd and haven't found a 0 cd yet
			if not lowestCdTime or cd < lowestCdTime then
				local isFree = self:IsUnitFree(unit) -- check for CC
				if isFree then
					lowestCdUnit = unit
					lowestCdTime = cd
				end
			end
		end
	end
	
	-- Priority pass
	if priorityTable then
		local highestUnit, highestPriority
		for i, unit in pairs(priorityTable) do
			local priority = self.basePriority[unit]
			if not highestPriority or priority < highestPriority then
				highestPriority = priority
				highestUnit = unit
			end
		end
		return highestUnit
	else
		return lowestCdUnit
	end
end

function InterruptPriority:Update()
	local interrupter = self:GetHighestPriority()
	local prevInterrupter = self.prevInterrupter
	printdebug("interrupter is ")
	printdebug(interrupter)
	if interrupter ~= prevInterrupter then
		printdebug(interrupter .. " next")
		ChatThrottleLib:SendAddonMessage("ALERT", addonPrefix, "show", "whisper", interrupter)
		ChatThrottleLib:SendAddonMessage("ALERT", addonPrefix, "hide", "whisper", prevInterrupter)
	end
	
	self.prevInterrupter = interrupter
end