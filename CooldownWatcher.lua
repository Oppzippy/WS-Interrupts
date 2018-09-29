local CooldownWatcher = {}

-- Table of spellid=>cooldown
local function CreateCooldownWatcher(tracked)
	local cdWatcher = {}
	setmetatable(cdWatcher, CooldownWatcher)
	
	-- Constructor
	
	cdWatcher.tracked = tracked
	cdWatcher.cooldowns = {}
end

function CooldownWatcher:CLEU(event, timestamp, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId)
	if subEvent == "SPELL_CAST_SUCCESS" then
		local cooldown = self.tracked[spellId]
		if cooldown then
			self:StartCooldown(sourceName, cooldown)
		end
	end
-end

function CooldownWatcher:StartCooldown(unit, cooldown)
	self.cooldowns[unit] = GetTime() + cooldown
end

function CooldownWatcher:GetCooldown(unit)
	local cd = self.cooldowns[unit]
	if cd then
		local remaining = cd - GetTime()
		return remaining <= 0 and nil or remaining
	end
end

function CooldownWatcher:IsOnCooldown(unit)
	local cd = self.cooldowns[unit]
	if cd then
		return self.cooldowns[unit] < GetTime()
	end
end