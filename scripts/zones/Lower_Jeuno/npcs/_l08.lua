-----------------------------------
-- Area: Lower Jeuno
--  NPC: Streetlamp
-- Involved in Quests: Community Service
-- !pos -44 0 -47 245
-----------------------------------
local lowerJeunoGlobal = require('scripts/zones/Lower_Jeuno/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    lowerJeunoGlobal.handleCheckingLight(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
