-----------------------------------
-- Flaming Crush
-- Hybrid
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local numHits = 3
    local accMod  = 1
    local dmgMod  = 10
    if
        target:getAllegiance() == 2 or
        target:getAllegiance() == 3 or
        target:getAllegiance() == 4 or
        target:getAllegiance() == 5 or
        target:getAllegiance() == 6
    then
        dmgMod = 5
    end
    local dmgModSubsequent = 1

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local baseDamage = xi.summon.avatarPhysicalMove(pet, target, petskill, numHits, accMod, dmgMod, dmgModSubsequent, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    damage       = math.floor(baseDamage.dmg + pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage, xi.element.FIRE, petskill)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, 3)

    target:takeDamage(damage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
