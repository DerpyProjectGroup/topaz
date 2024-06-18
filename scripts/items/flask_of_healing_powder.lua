-----------------------------------
-- ID: 5322
-- Item: flask_of_healing_powder
-- Item Effect: Restores 25% of Maximum HP to Party members within 10'
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
        member:messageBasic(xi.msg.basic.RECOVERS_HP, 0, member:addHP((member:getMaxHP() / 100) * 25))
    end)
end

return itemObject
