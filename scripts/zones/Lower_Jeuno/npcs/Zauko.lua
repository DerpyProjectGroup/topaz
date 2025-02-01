-----------------------------------
-- Area: Lower Jeuno
--  NPC: Zauko
-- Involved in Quests: Community Service
-- !pos -3 0 11 245
-----------------------------------
require('scripts/zones/Lower_Jeuno/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local hasMembershipCard = player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) and 1 or 0

    player:startEvent(118, hasMembershipCard) -- NPC says: text reads: I am Zauko I patrol Lower Jueno. Player given choice to drop membership card if they have one.
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        player:delKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD)
    end
end

return entity
