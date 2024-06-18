-----------------------------------
-- ID: 5832
-- Item: flask_of_healing_mist
-- Item Effect: Restores 600 HP to Party members within 10'
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(10, function(member)
        if member:hasStatusEffect(xi.effect.CURSE_II) then
            member:messageBasic(xi.msg.basic.NO_EFFECT)
            return 1
        end
        member:messageBasic(xi.msg.basic.RECOVERS_HP, 0, member:addHP(600 * xi.settings.main.ITEM_POWER))
    end)
end

return itemObject
