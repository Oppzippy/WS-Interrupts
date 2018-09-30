local function ParseInterruptString(str)
	local priorities = { strsplit(";", str) }
	
	local priorityList = {}
	
	for i, priority in pairs(priorities) do
		local order = { strsplit(">,", priority) }
		table.insert(priorityList, order)
	end
	
	return priorityList
end