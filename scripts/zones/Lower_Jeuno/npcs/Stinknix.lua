-----------------------------------
-- Area: Lower Jeuno
--  NPC: Stinknix
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.PINCH_OF_POISON_DUST,      294,
        xi.item.PINCH_OF_VENOM_DUST,      1035,
        xi.item.PINCH_OF_PARALYSIS_DUST,  2000,
        xi.item.IRON_ARROW,                  7,
        xi.item.CROSSBOW_BOLT,               5,
        xi.item.CRUDE_ARROW,                 1,
        xi.item.CRUDE_ARROW_P1,              3,
        xi.item.CRUDE_ARROW_P2,              5,
        xi.item.CRUDE_ARROW_P3,              7,
        xi.item.CRUDE_ARROW_P4,              9,
        xi.item.CRUDE_ARROW_P5,             11,
        xi.item.CRUDE_ARROW_P6,             13,
        xi.item.CRUDE_ARROW_P7,             15,
        xi.item.DOGBOLT,                     1,
        xi.item.DOGBOLT_P1,                  3,
        xi.item.DOGBOLT_P2,                  5,
        xi.item.DOGBOLT_P3,                  7,
        xi.item.DOGBOLT_P4,                  9,
        xi.item.DOGBOLT_P5,                 11,
        xi.item.ANTIQUE_BULLET,             15,
        xi.item.ANTIQUE_BULLET_P1,          25,
        xi.item.GRENADE,                   107,
        2865,                            10000, -- Dutchy Waystone

    }

    player:showText(npc, ID.text.JUNK_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
