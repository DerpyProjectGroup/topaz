-----------------------------------
--  Toxic Spit
--
--  Description: Spews a toxic glob at a single target. Effect: Poison
--  Type: Magical Water
--  Utsusemi/Blink absorb: Ignores shadows
--  Notes: Additional effect can be removed with Poisona.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 2.5)
    local power  = math.floor(mob:getMainLvl() / 5 + 3)
    local duration = 120
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 180
            duration = math.max(280, duration * (tp/1000)) -- Minimum 4:40 minutes. Maximum 9 minutes.
        end
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, duration)

    return damage
end

return mobskillObject
