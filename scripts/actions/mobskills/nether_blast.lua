-----------------------------------
-- Ranged Attack
-- Deals a ranged attack to a single target.
-----------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Ranged attack only used when target is out of range
    if (mob:checkDistance(target) > 2) then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getMainLvl() * 5 + 10 -- http://wiki.ffo.jp/html/4045.html
    local dmgmod = 1
    local ignoreres = true

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ignoreres)

    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return damage
end

return mobskillObject
