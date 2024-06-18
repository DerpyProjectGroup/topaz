-----------------------------------
-- ID: 4129
-- Item: Ether +1
-- Item Effect: Restores 25 MP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getMP() == target:getMaxMP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.CURSE_II) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
        return 1
    end
    
    target:messageBasic(xi.msg.basic.RECOVERS_MP, 0, target:addMP(25 * xi.settings.main.ITEM_POWER))
end

return itemObject
