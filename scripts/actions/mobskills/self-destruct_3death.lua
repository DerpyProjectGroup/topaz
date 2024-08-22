-----------------------------------
-- Self-Destruct
-- Bomb Cluster Self Destruct - 3 Bombs up
-----------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if (mob:getHPP() > 60 or mob:getAnimationSub() ~= 4) and math.random() > 0.2 then -- 20% chance for all bombs to explode
        return 1
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * math.random(10, 18)
    local dmgmod = 1

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return damage
end

return mobskillObject
