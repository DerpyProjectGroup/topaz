-----------------------------------
-- Freezebite
-- Great Sword weapon skill
-- Skill Level: 100
-- Delivers an ice elemental attack. Damage varies with TP.
-- Aligned with the Snow Gorget & Breeze Gorget.
-- Aligned with the Snow Belt & Breeze Belt.
-- Element: Ice
-- Modifiers: STR:30%  INT:20%
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      3.00
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1.5 params.ftp300 = 3
    params.str_wsc = 0.3 params.int_wsc = 0.2
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    local damage, _, _, _ = xi.weaponskills.doPhysicalWeaponskill(mob, target, 0, params, 0, nil, true, nil)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return damage
end

return mobskillObject
