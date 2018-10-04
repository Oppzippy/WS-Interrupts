function(...)
    local event, timestamp, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId = ...
    
    local success = aura_env.cooldownWatcher:CLEU(...)
    
    if success then
        aura_env:UpdateUnit(destName)
        return
    end
    
    local isDestPlayer = string.sub(destGUID, 6) == "player"    
    
    if isDestPlayer and (subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_REMOVED") then
        
        if aura_env.badDebuffs[spellId] then
            aura_env:UpdateUnit(destName)
        end
    elseif isDestPlayer and subEvent == "UNIT_DIED" then
        aura_env:UpdateUnit(destName)
    end
end

