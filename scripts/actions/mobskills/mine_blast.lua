-----------------------------------
-- Mine Blast
-- 20 Aoe Fire damage from a bomb
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    -- TODO: Shift Proof This
    local baseDamage = mob:getWeaponDmg()
    local wDmgMultiplier = 5
    local dmgmod = 20
    local NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE = 17092962

    -- mine blast is being used to take out walls in lebros excavation duty
    -- with the params above - mine blast in Nyzul does 9300 dmg to players
    -- so - if the mob using the skill is the mine in Nyzul Isle Investigation - adjust the damage
    -- Thf NMs hits for 300-400 pre shell/barfira
    -- Rng NM a bit less
    -- Regular Thfs for ~150
    if (mob:getID() == NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE) then
        dmgmod = 1
        local mobVar = mob:getLocalVar('wDmgMultiplier')
        if (mobVar > 0) then
            wDmgMultiplier = mobVar
        else
            wDmgMultiplier = 2
        end
    end

    if (mob:getID() >= 17072173 and mob:getID() <= 17072177) then -- Cheese Hoarder Gigiroon
        dmgmod = 1
        -- Cheese's bombs do flat dmg pre-shell and barfira (500 or 100)
        baseDamage = mob:getLocalVar('MineDamage')
    end

    local damage = baseDamage * wDmgMultiplier

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    mob:setHP(0)

    return damage
end

return mobskillObject
