-----------------------------------
--  Firespit
--  Description: Deals fire damage to an enemy.
--  Type: Magical (Fire)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1639 then
            return 0
        else
            return 1
        end
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage  = mob:getWeaponDmg() * 4
    local numhits = math.random(2, 3)
    local dmgmod = 1

    if
        mob:getMainJob() == xi.job.BLM or
        mob:getMainJob() == xi.job.WHM
    then
        numhits = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    if mob:getFamily() == 305 then -- Gotoh Zha the Redolent
        dmgmod = 3
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, numhits)

    if mob:getFamily() == 305 then -- Gotoh Zha the Redolent
        damage = damage * (1 - utils.clamp(math.max(mob:checkDistance(target) - 10, 0) / 25, 0, .8))
    end

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end
return mobskillObject
