-----------------------------------
-- Monstrosity
-----------------------------------
-- Log ID: 4, Quest ID: 34
-- Suspicious Hume : !pos -491.817 24.988 -618.552 109
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.MONSTROSITY)

quest.reward = {}

local baseNpcEvents =
{
    [xi.zone.PASHHOW_MARSHLANDS] = 40,
    [xi.zone.NORTHERN_SAN_DORIA] = 882,
    [xi.zone.PORT_BASTOK]        = 418,
    [xi.zone.PORT_WINDURST]      = 880,
}

local tradeItems =
{
    xi.item.LIZARD_TAIL,
    xi.item.RABBIT_HIDE,
    xi.item.TWO_LEAF_MANDRAGORA_BUD,
}

local suspiciousCityNpc =
{
    onTrade = function(player, npc, trade)
        if player:hasKeyItem(xi.ki.RING_OF_SUPERNAL_DISJUNCTION) then
            return
        end

        for _, itemId in ipairs(tradeItems) do
            if npcUtil.tradeHasExactly(trade, itemId) then
                return quest:progressEvent(baseNpcEvents[player:getZoneID()] + 1, itemId)
            end
        end
    end,

    onTrigger = function(player, npc)
        local baseEvent = baseNpcEvents[player:getZoneID()]

        if not player:hasKeyItem(xi.ki.RING_OF_SUPERNAL_DISJUNCTION) then
            return quest:event(baseEvent)
        else
            return quest:event(baseEvent + 2)
        end
    end,
}

local tradeEventFinish = function(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.RING_OF_SUPERNAL_DISJUNCTION)
end

local odysseanPassageNpc =
{
    onTrigger = function(player, npc)
        if player:hasKeyItem(xi.ki.RING_OF_SUPERNAL_DISJUNCTION) then
            return quest:progressEvent(baseNpcEvents[player:getZoneID()] + 3)
        end
    end,
}

local odysseanPassageOnEventFinish = function(player, csid, option, npc)
    if option == 1 then
        player:setPos(-358, -3.4, -440, 64, xi.zone.FERETORY)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Suspicious_Hume'] = quest:progressEvent(40),

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Odyssean_Passage']  = odysseanPassageNpc,
            ['Suspicious_Elvaan'] = suspiciousCityNpc,

            onEventFinish =
            {
                [883] = tradeEventFinish,
                [885] = odysseanPassageOnEventFinish,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Odyssean_Passage'] = odysseanPassageNpc,
            ['Suspicious_Hume']  =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.RING_OF_SUPERNAL_DISJUNCTION) then
                        return quest:event(41)
                    else
                        return quest:event(42)
                    end
                end,
            },

            onEventFinish =
            {
                [43] = odysseanPassageOnEventFinish,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Odyssean_Passage'] = odysseanPassageNpc,
            ['Suspicious_Galka'] = suspiciousCityNpc,

            onEventFinish =
            {
                [419] = tradeEventFinish,
                [421] = odysseanPassageOnEventFinish,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Odyssean_Passage']    = odysseanPassageNpc,
            ['Suspicious_Tarutaru'] = suspiciousCityNpc,

            onEventFinish =
            {
                [881] = tradeEventFinish,
                [883] = odysseanPassageOnEventFinish,
            },
        },

        [xi.zone.FERETORY] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 2
                end,
            },

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    if option == 1 then
                        -- TODO: Give monstrosity things here or earlier, and wire up this update
                        player:updateEvent(7, 10, 2, 1024, 2, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    -- NOTE: The default events for the Suspicious NPCs require additional work to support
    -- the items that they can provide, and will most likely need support in the monstrosity
    -- global, along with event update/finish wiring here.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PASHHOW_MARSHLANDS] =
        {

            ['Odyssean_Passage'] = odysseanPassageNpc,
            ['Suspicious_Hume']  = quest:event(45):replaceDefault(),

            onEventFinish =
            {
                [43] = odysseanPassageOnEventFinish,
            }
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Odyssean_Passage']  = odysseanPassageNpc,
            ['Suspicious_Elvaan'] = quest:event(886):replaceDefault(), -- TODO: 886 may be once per zone or once, 887 after

            onEventFinish =
            {
                [885] = odysseanPassageOnEventFinish,
            }
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Odyssean_Passage'] = odysseanPassageNpc,
            ['Suspicious_Galka'] = quest:event(422):replaceDefault(),

            onEventFinish =
            {
                [421] = odysseanPassageOnEventFinish,
            }
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Odyssean_Passage']    = odysseanPassageNpc,
            ['Suspicious_Tarutaru'] = quest:event(884):replaceDefault(),

            onEventFinish =
            {
                [883] = odysseanPassageOnEventFinish,
            }
        },
    },
}

return quest
