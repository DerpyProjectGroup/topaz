-----------------------------------
-- Self-Destruct
-- Bomb Cluster Self Destruct - 3 Bombs up
-----------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getHPP() > 60 or mob:getAnimationSub() ~= 4 then
        return 1
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 18
    local dmgmod = 1
    local bombTossHPP = skill:getMobHPP() / 100

    -- Razon - ENM: Fire in the Sky
    if mob:getHPP() <= 66 and mob:getPool() == 3333 then
        bombTossHPP = 0
    end

    damage = damage * bombTossHPP

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setAnimationSub(5)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return damage
end

return mobskillObject
