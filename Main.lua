local userInput = ParseInterruptString("Oppystar>Oppytest>Oppytesttwo")

-- End user input
local priorityList = {}

local cooldownWatcher = CreateCooldownWatcher(interrupts)
aura_env.cooldownWatcher = cooldownWatcher

for i, priorityInput in pairs(userInput) do
	table.insert(priorityList, CreateInterruptPriority(priorityInput, cooldownWatcher))
end

function aura_env:UpdatePriorities()
	if self.running then
		for i, interruptPriority in pairs(priorityList) do
			interruptPriority:Update()
		end
	end
end

function aura_env:Stop()
	self.running = false
	ChatThrottleLib:SendAddonMessage("NORMAL", addonPrefix, "hide", "raid")
end

function aura_env:Start()
	self.running = true
end

aura_env.running = false