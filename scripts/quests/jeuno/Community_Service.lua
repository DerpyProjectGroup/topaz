-----------------------------------
-- Community Service
-----------------------------------
-- Log ID: 3, Quest ID: 15
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE)

-----------------------------------
-- Functions Used By Multiple NPCs
-----------------------------------

local function fetchLampCs(lampNumber)
    return 120 + lampNumber -- cutscene 120 - 131 are cutscenes for the lamps
end

local function handleLightingStreetLamp(player, npc, lampNumber)
    local lampCs = fetchLampCs(lampNumber)

    if npc:getAnimation() == xi.anim.OPEN_DOOR then
        return quest:progressEvent(lampCs, 2)             -- The lamp is already lit
    else
        return quest:progressEvent(lampCs, 1, lampNumber) -- Light the lamp? Yes/No
    end
end

local function countUnlitLamps()
    local ID = zones[xi.zone.LOWER_JEUNO]
    local lampsRemaining = 12

    for i = 0, 11 do
        local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)
        if lamp and lamp:getAnimation() == xi.anim.OPEN_DOOR then
            lampsRemaining = lampsRemaining - 1
        end
    end

    return lampsRemaining
end

local function handleLampEventFinish(player, option, npc)
    if option == 1 then
        local ID = zones[xi.zone.LOWER_JEUNO]

        npc:setAnimation(xi.anim.OPEN_DOOR)

        local lampsRemaining = countUnlitLamps()

        quest:setVar(player, 'NumberLampsLit', 12 - lampsRemaining)

        player:messageSpecial(ID.text.LAMP_MSG_OFFSET - 1)                     -- You light the lamp.
        if lampsRemaining == 0 then
            player:messageSpecial(ID.text.LAMP_MSG_OFFSET)                     -- All the lamps are lit.
        else
            player:messageSpecial(ID.text.LAMP_MSG_OFFSET + 1, lampsRemaining) -- You have # more lamps to go.
        end
    end
end

local function handleFailingToLightLamp(lampNumber)
    local lampCs = fetchLampCs(lampNumber)
    return quest:progressEvent(lampCs, 3):oncePerZone() -- You have failed to light all the lamps in time.
end

local function passedTimeToLightLamps(player)
    local daysPassed = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
    return (daysPassed == 1 and VanadielHour() >= 1) or daysPassed > 1
end

quest.reward =
{
    fame     = 15,
    fameArea = xi.fameArea.JEUNO,
    title    = xi.title.TORCHBEARER,
}

quest.sections =
{
    -----------------------------------
    -- NPC Offers Quest
    -----------------------------------
    {
        check = function(player, status, vars)
            local hour = VanadielHour()
            local rightTime = hour >= 18 and hour < 21
            local hasNotAlreadyStarted = quest:getVar(player, 'DayStarted') == 0
            local allLampsLit = countUnlitLamps() == 0
            --we dont need to check for someone else on the quest here - that is handled in onEventUpdate for CS 116
            local conditions = rightTime and hasNotAlreadyStarted and not allLampsLit

            return status ~= xi.questStatus.QUEST_ACCEPTED and conditions
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Zauko'] = {
                onTrigger = function(player, npc)
                    local hasCompletedQuest = player:hasCompletedQuest(quest.areaId, quest.questId) and 1 or 0
                    return quest:progressEvent(116, hasCompletedQuest) -- NPC says: Soon darkness falls soon its time to light the lamps. Maybe you could help?. Two options. adding 0 arument means first time doing quest. 1 argument means second time
                end,
            },

            onEventUpdate =
            {
                [116] = function(player, csid, option, npc)
                    if option == 0 then -- player accepts quest
                        local noOneElseIsOnQuest = GetServerVariable('[JEUNO]CommServicePlayer') == 0
                        local hasCompletedQuest = player:hasCompletedQuest(quest.areaId, quest.questId) and 1 or 0

                        if noOneElseIsOnQuest then
                            player:updateEvent(1, hasCompletedQuest)                      --NPC says: Dont worry. Its easy. See the twelve lamps...
                            SetServerVariable('[JEUNO]CommServicePlayer', player:getID()) -- start quest
                            quest:setVar(player, 'DayStarted', VanadielDayOfTheYear())

                            if player:getQuestStatus(quest.areaId, quest.questId) == xi.questStatus.QUEST_AVAILABLE then
                                quest:begin(player)
                            end
                        else
                            player:updateEvent(0, hasCompletedQuest) -- NPC says: someone else is already on the quest
                        end
                    end
                end
            }
        }
    },
    -----------------------------------
    -- During Quest
    -----------------------------------
    {
        check = function(player, status, vars)
            local playerIsOnQuest = GetServerVariable('[JEUNO]CommServicePlayer') == player:getID()
            local notAllLampsLit = quest:getVar(player, 'NumberLampsLit') < 12
            local conditions = playerIsOnQuest and not passedTimeToLightLamps(player) and notAllLampsLit

            return status ~= xi.questStatus.QUEST_AVAILABLE and conditions
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Zauko'] = quest:progressEvent(114), -- NPC says: Now you can begin. Do your best to finish by...
            ['_l11'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 11)
                end,
            },
            ['_l10'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 10)
                end,
            },
            ['_l09'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 9)
                end,
            },
            ['_l08'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 8)
                end,
            },
            ['_l07'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 7)
                end,
            },
            ['_l06'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 6)
                end,
            },
            ['_l05'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 5)
                end,
            },
            ['_l04'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 4)
                end,
            },
            ['_l03'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 3)
                end,
            },
            ['_l02'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 2)
                end,
            },
            ['_l01'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 1)
                end,
            },
            ['_l00'] = {
                onTrigger = function(player, npc)
                    return handleLightingStreetLamp(player, npc, 0)
                end,
            },

            onEventFinish = {
                [120] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [121] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [122] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [123] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [124] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [125] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [126] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [127] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [128] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [129] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [130] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,

                [131] = function(player, csid, option, npc)
                    handleLampEventFinish(player, option, npc)
                end,
            }
        }
    },
    -----------------------------------
    -- Out of Time. Oh No! You failed the quest.
    -----------------------------------
    {
        check = function(player, status, vars)
            local notAllLampsLit = quest:getVar(player, 'NumberLampsLit') < 12
            local playerStartedQuest = quest:getVar(player, 'DayStarted') > 0
            local conditions = notAllLampsLit and passedTimeToLightLamps(player) and playerStartedQuest

            return status ~= xi.questStatus.QUEST_AVAILABLE and conditions
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Zauko'] = quest:progressEvent(119), -- NPC says: I am disapointed stay sharp next time
            ['_l11'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(11)
                end
            },
            ['_l10'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(10)
                end
            },
            ['_l09'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(9)
                end
            },
            ['_l08'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(8)
                end
            },
            ['_l07'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(7)
                end
            },
            ['_l06'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(6)
                end
            },
            ['_l05'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(5)
                end
            },
            ['_l04'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(4)
                end
            },
            ['_l03'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(3)
                end
            },
            ['_l02'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(2)
                end
            },
            ['_l01'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(1)
                end
            },
            ['_l00'] = {
                onTrigger = function(player, npc)
                    return handleFailingToLightLamp(0)
                end
            },

            onEventFinish = {
                [119] = function(player, csid, option, npc)
                    quest:setVar(player, 'NumberLampsLit', 0)
                    quest:setVar(player, 'DayStarted', 0)
                end,
            },
        }
    },
    -----------------------------------
    -- Complete Quest
    -----------------------------------
    {
        check = function(player, status, vars)
            local allLampsLit = quest:getVar(player, 'NumberLampsLit') == 12
            local playerIsOnQuest = quest:getVar(player, 'DayStarted') > 0
            local conditions = allLampsLit and playerIsOnQuest

            return status ~= xi.questStatus.QUEST_AVAILABLE and conditions
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Zauko'] = {
                onTrigger = function(player, npc)
                    local hasCompletedQuest = player:hasCompletedQuest(quest.areaId, quest.questId)
                    local hasMembershipCard = player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD)
                    local offerMembershipCard = (hasCompletedQuest and not hasMembershipCard) and 1 or 0

                    return quest:progressEvent(117, offerMembershipCard) -- 0 argument means first time doing quest. Text reads: Good work. I cant pay you. But I hope you found the experience rewarding.
                end,
            },

            onEventFinish = {
                [117] = function(player, csid, option, npc)
                    local hasCompletedQuest = player:hasCompletedQuest(quest.areaId, quest.questId)

                    if not hasCompletedQuest then -- first time doing quest - get 15 fame here and 15 from quest.rewards for 30 total - repetitions of quest is 15 fame
                        player:addFame(xi.fameArea.JEUNO, 15)
                    end

                    if hasCompletedQuest and option == 1 then -- only get this key item for repeating the quest
                        -- NOTE: if you cant get this key item when you complete the quest try adding a return before npcUtil
                        npcUtil.giveKeyItem(player, xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD)
                    end

                    quest:complete(player)
                end,
            },
        }
    },
    -----------------------------------
    -- Dialogue After Completing Quest For Rest Of Night
    -----------------------------------
    {
        check = function(player, status, vars)
            local allLampsLit = countUnlitLamps() == 0
            local playerIsLastOneOnQuest = GetServerVariable('[JEUNO]CommServicePlayer') == player:getID()
            local playerIsntDoingQuest = quest:getVar(player, 'DayStarted') == 0
            local conditions = allLampsLit and playerIsLastOneOnQuest and playerIsntDoingQuest

            return status == xi.questStatus.QUEST_COMPLETED and conditions
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Zauko'] = quest:progressEvent(113) -- NPC says: Theres nothing like city streets lit up at night
        }
    }
}

return quest
