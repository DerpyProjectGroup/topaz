-----------------------------------
-- Freezebite
-- Great Sword weapon skill
-- Delivers an ice elemental attack. Damage varies with TP.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    --[[local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.5, 3.0 }
    params.str_wsc = 0.3 params.int_wsc = 0.2
    local damage, _, _, _ = xi.weaponskills.doPhysicalWeaponskill(mob, target, 0, params, 0, nil, true, nil)]]
    local damage = mob:getWeaponDmg() * 3
    local dmgmod = 2
    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return damage
end

return mobskillObject
