-----------------------------------
-- Bomb Toss
-- Throws a bomb at an enemy.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local suicideCheck = math.random(0, 100)

    if
        not mob:isNM() and
        not mob:isInDynamis() and
        suicideCheck <= 15 -- 15% chance to use bomb_toss_suicide if bomb_toss is picked (50%)
    then
        mob:useMobAbility(592)
        return 1
    end
    
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    if mob:getName() == 'Wilywox_Tenderpalm' then
        local bombTossHPP = 1 + (mob:getMaxHP() / mob:getHP()) / 100 * 1.25 -- Bomb Toss power increases at lower HP
        local power = math.random(5, 7)
        damage = mob:getWeaponDmg() * bombTossHPP * power
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
