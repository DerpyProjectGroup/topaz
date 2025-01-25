-----------------------------------
-- Vulcanian Impact
-- Notes: This ability is used by both Big Bomb and Friar's Lanterns in the area
--  that drop the item to spawn Big Bomb
--
--  Vulcanian Impact is only used when the bomb is in default state, or has
--  grown once.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local anim = (mob:getAnimationSub() + 1) % 4

    if anim == 1 or anim == 2 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local targetcurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset = targetmaxHP * 0.10
    local dmg = 0
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)

    if targetcurrentHP > hpset then
        dmg = targetcurrentHP - hpset
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE, { breakBind = false })
    return dmg
end

return mobskillObject
