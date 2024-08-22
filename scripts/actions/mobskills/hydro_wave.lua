-----------------------------------
--  Hydro Wave
--  Description: Deals water damage to enemies around the caster.
--  Type: Magical (Water)
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Area of Effect (10 yalms)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage   = mob:getWeaponDmg()
    local power    = math.random(1, 16)
    local duration = math.floor(30 * xi.mobskills.applyPlayerResistance(mob, xi.effect.ENCUMBRANCE_II, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, 0))

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 2.5, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    mob:addStatusEffect(xi.effect.STONESKIN, 0, 0, 180, 2, 1500)
    --local remove = 0xFFFF
    local numberToUnequip = 1
    -- xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ENCUMBRANCE_II, power, 0, duration)

    -- Need a list that corresponds to the range from xi.slot.MAIN to xi.slot.BACK - but mutable without consequence
    local equipmentSlots = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
    for i=1, numberToUnequip do
        index = math.random(#equipmentSlots)
        slot = equipmentSlots[index]
        table.remove(equipmentSlots, index)
        target:unequipItem(slot)
    end

    return damage
end

return mobskillObject
