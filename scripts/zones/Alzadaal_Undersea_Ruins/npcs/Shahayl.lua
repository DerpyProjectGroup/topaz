-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: Shahayl
-- Type: Assault
-- ID: 17072276 - Index 148
-- !pos 145.787 0 31.166 72
-----------------------------------

require('scripts/globals/missions')
require('scripts/globals/assault')
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local toauMission = player:getCurrentMission(xi.mission.log_id.TOAU)

    -- Assault --
    if (toauMission >= xi.mission.id.toau.PRESIDENT_SALAHEEM) then
        local imperialStanding = player:getCurrency('imperial_standing')
        local floorProgressNyzulInvestigation = 0 -- ToDo get floorProgress and add 1, expcept for 100 (subtract 4)
        local floorProgressNyzulUncharted = 0
        local nyzulTokens = player:getAssaultPoint(xi.assault.assaultArea.NYZUL_ISLE)
        
        if (player:hasKeyItem(xi.ki.NYZUL_ISLE_ASSAULT_ORDERS) and player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) == false) then
            player:startEvent(412, 50, nyzulTokens, floorProgressNyzulInvestigation, imperialStanding, floorProgressNyzulUncharted)
            return
        end
    end

    -- default -- 
    player:startEvent(413)
    
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- ASSAULT --
    if (csid == 412 and option == 1) then
        player:delCurrency('imperial_standing', 50)
        player:addKeyItem(xi.ki.ASSAULT_ARMBAND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ASSAULT_ARMBAND)
    end
end

return entity