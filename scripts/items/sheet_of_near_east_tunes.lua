-----------------------------------
-- ID: 6696
-- Item: Near East Tunes
-- Grants keyitem: SHEET_OF_NEAR_EAST_TUNES
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    -- TODO: The error message returned by this is wrong
    return target:hasKeyItem(xi.keyItem.SHEET_OF_NEAR_EAST_TUNES) and 1 or 0
end

itemObject.onItemUse = function(target)
    -- TODO: This actually produces the message: `->Obtained key item: {key item name}.`
    -- TODO: We don't yet have this message type mapped out
    npcUtil.giveKeyItem(target, xi.keyItem.SHEET_OF_NEAR_EAST_TUNES)
end

return itemObject