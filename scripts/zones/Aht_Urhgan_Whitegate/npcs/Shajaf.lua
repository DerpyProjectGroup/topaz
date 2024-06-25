-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Shajaf
-----------------------------------
local entity = {}

local wildcatBadges = {
    xi.ki.PSC_WILDCAT_BADGE,
    xi.ki.PFC_WILDCAT_BADGE,
    xi.ki.SP_WILDCAT_BADGE,
    xi.ki.LC_WILDCAT_BADGE,
    xi.ki.C_WILDCAT_BADGE,
    xi.ki.S_WILDCAT_BADGE,
    xi.ki.SM_WILDCAT_BADGE,
    xi.ki.CS_WILDCAT_BADGE,
    xi.ki.SL_WILDCAT_BADGE,
    xi.ki.FL_WILDCAT_BADGE,
    xi.ki.CAPTAIN_WILDCAT_BADGE
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local imperialStanding = player:getCurrency('imperial_standing')

    local hasBadge = false
    for _, badge in ipairs(wildcatBadges) do
        if player:hasKeyItem(badge) then
            hasBadge = true
            break
        end
    end

    -- ISNM accepted but not completed. TODO: Check if KIs expire aswell.
    if
        player:hasKeyItem(xi.ki.CONFIDENTIAL_IMPERIAL_ORDER) or
        player:hasKeyItem(xi.ki.SECRET_IMPERIAL_ORDER)
    then
        player:startEvent(161)

    -- ISNM completed. 1 day lockout hasn't expired.
    elseif player:getCharVar('[ISNM]Accepted') == 1 then
        player:startEvent(163)

    -- Can purchuase KI.
    elseif hasBadge then
        player:startEvent(160, imperialStanding, 1)

    -- Default.
    else
        player:startEvent(162)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    local imperialStanding = player:getCurrency('imperial_standing')

    if csid == 160 then
        -- Lv. 60 fight
        if
            option == 1 and
            imperialStanding >= 2000
        then
            player:setCharVar('[ISNM]Accepted', 1, getMidnight())
            player:delCurrency('imperial_standing', 2000)
            npcUtil.giveKeyItem(player, xi.ki.CONFIDENTIAL_IMPERIAL_ORDER)

        -- Lv. 75 fight
        elseif
            option == 2 and
            imperialStanding >= 3000
        then
            player:setCharVar('[ISNM]Accepted', 1, getMidnight())
            player:delCurrency('imperial_standing', 3000)
            npcUtil.giveKeyItem(player, xi.ki.SECRET_IMPERIAL_ORDER)
        end
    end
end

return entity
