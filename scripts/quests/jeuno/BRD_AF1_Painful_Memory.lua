-----------------------------------
-- Painful Memory
-----------------------------------
-- Log ID: 3, Quest ID: 63
-- Mertaire: !gotoid 17780764
-- Waters_of_Oblivion: !gotoid 17457347
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)

quest.reward =
{
    item = xi.item.PAPER_KNIFE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
            player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD) and
            player:getMainJob() == xi.job.BRD
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    local initialCS = quest:getVar(player, 'initialCS')

                    if initialCS == 0 then
                        return quest:progressEvent(138)
                    elseif initialCS == 1 then
                        return quest:progressEvent(137)
                    end
                end,
            },

            onEventFinish =
            {
                [138] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'initialCS', 0)
                        npcUtil.giveKeyItem(player, xi.ki.MERTAIRES_BRACELET)
                    else
                        quest:setVar(player, 'initialCS', 1)
                    end
                end,

                [137] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'initialCS ', 0)
                        npcUtil.giveKeyItem(player, xi.ki.MERTAIRES_BRACELET)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(136)
                end,
            },

            ['Mataligeat'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 1 then
                        return quest:event(141)
                    end
                end,
            },
        },

        [xi.zone.RANGUEMONT_PASS] =
        {
            ['Waters_of_Oblivion'] =
            {
                onTrigger = function(player, npc)
                    local nmKilled = quest:getVar(player, 'nmKilled')

                    if
                        player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) and
                        npcUtil.popFromQM(player, npc, ID.mob.TROS, { claim = true, hide = 0 }) and
                        nmKilled == 0
                    then
                        return quest:noAction()
                    elseif nmKilled == 1 then
                        return quest:progressEvent(8)
                    end
                end,
            },

            ['Tros'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MERTAIRES_BRACELET)
                    end
                end,
            },
        },
    },
}

return quest
