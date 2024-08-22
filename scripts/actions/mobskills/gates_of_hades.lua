-----------------------------------
--  Gates of Hades
--  Description: Deals severe Fire damage to enemies within an area of effect. Additional effect: Burn
--  Type:  Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 20' radial
--  Notes: Only used when a cerberus's health is 25% or lower (may not be the case for Orthrus). The burn effect takes off upwards of 20 HP per tick.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1793 then
            return 0
        else
            return 1
        end
    end

    local mobhp = mob:getHPP()

    if mobhp <= 25 then
        if (mob:getID() == 17093004) and (mob:getInstance():getStage() ~= 100) then -- Nyzul Isle Cerberus will only use this on floor 100 TODO: Shift Proof This
            return 1
        end

        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 6
    local power = 21
    local dmgmod = 1.8

    -- TODO: MobID References cleanup.
    if (mob:getID() == 17093004) then -- Nyzul Isle Cerberus https://youtu.be/e7CEeeRQ8qU?t=274
        power = 20
        dmgmod = 0.5
    elseif (mob:getID() == 17027485) then -- Sarameya
        power = 40
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, 60)

    return damage
end

return mobskillObject
