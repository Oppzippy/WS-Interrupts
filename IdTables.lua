local badDebuffs = {
	[265646] = true, -- Will of the Corrupter (Zek'Voz)
}

-- From nnogga's interrupt tracker
local interrupts = { --[spellId]=cooldown
    [47528]  = 15, --Mind Freeze
    [106839] = 15, --Skull Bash
    [78675]  = 60, --Solar Beam
    [183752] = 15, --Consume Magic
    [147362] = 24, --Counter Shot
    [187707] = 15, --Muzzle
    [2139]   = 24, --Counter Spell
    [116705] = 15, --Spear Hand Strike
    [96231]  = 15, --Rebuke
    [1766]   = 15, --Kick
    [57994]  = 12, --Wind Shear
    [6552]   = 15, --Pummel
    [119910] = 24, --Spell Lock Command Demon
    [19647]  = 24, --Spell Lock if used from pet bar
    [132409] = 24, --Spell Lock Command Demon Sacrifice
    [15487]  = 45, --Silence
}