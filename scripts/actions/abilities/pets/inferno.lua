-----------------------------------
-- Inferno
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local level = player:getMainLvl() * 2

    if player:getMP() < level then
        return 87, 0
    end

    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    local level = pet:getMainLvl()
    local damage = 48 + (level * 8)
    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.FIRE)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, 1)

    master:setMP(0)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.FIRE)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject