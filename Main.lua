local userInput = {
	
}

-- End user input
local priorityLists = {}

local cooldownWatcher = CreateCooldownWatcher(interrupts)
aura_env.cooldownWatcher = cooldownWatcher

for i, priorityInput in pairs(userInput) do
	table.insert(priorityLists, CreateInterruptPriority(priorityInput, cooldownWatcher)
end

