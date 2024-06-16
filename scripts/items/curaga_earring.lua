-----------------------------------
-- ID: 14759
-- Item: Curaga Earring
-- Item Effect: Casts Curaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(30, function(member)
        local healAmount = math.random(60, 90)

        healAmount = healAmount + (healAmount * (member:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))
        healAmount = healAmount * xi.settings.main.CURE_POWER

        local diff = (member:getMaxHP() - member:getHP())
        if healAmount > diff then
            healAmount = diff
        end
        if member:hasStatusEffect(xi.effect.CURSE_II) then
            member:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            member:addHP(healAmount)
            member:messageBasic(xi.msg.basic.RECOVERS_HP, 0, healAmount)
        end
    end)
end

return itemObject
