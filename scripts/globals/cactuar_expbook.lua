-----------------------------------
-- Cactuar Field Manual
-----------------------------------
xi = xi or {}
xi.cactuarRegimes = xi.cactuarRegimes or {}

function getZoneNameByNumber(zoneNumber)
    for zoneName, zoneID in pairs(xi.zone) do
        if zoneID == zoneNumber then
            return zoneName
        end
    end
    return 'UNKNOWN_ZONE'
end

local function delProwessEffect(player, effect)
    if player:hasStatusEffect(effect) then
        player:delStatusEffectSilent(effect)
    end
end

xi.cactuarRegimes.initializeBooks = function(zone)
    local zoneID = zone:getID()
    local zoneData = xi.cactuarRegimes.zoneData[zoneID]

    for i = 1, #zoneData.books do
        local bookData = zoneData.books[i]
        local trainingData = zoneData.trainingData[i]
        local bookName = bookData.name
        local expBook = zone:insertDynamicEntity({
            objtype = xi.objType.NPC,
            name = bookName,
            look = bookData.look,
            x = bookData.x,
            y = bookData.y,
            z = bookData.z,
            rotation = bookData.rotation,
            widescan = 1,
            onTrade = function(player, npc, trade)
            end,
            onTrigger = function(player, npc)
                -----------------------------------
                -- Menu Structure
                -----------------------------------
                local tabs = player:getCurrency('valor_point')

                -- Header
                local mainMenu =  {} -- "What will you do?"
                    -- Menu Options
                    local mainMenu_Options = {}

                local fieldSupportCatagoryMenu =  {} -- Which catagory?
                    -- Menu Options
                    local fieldSupportCatagoryMenu_Options =
                    {
                    }

                local fieldSupportMenu =  {} -- "Which Ones?"
                    local fieldSupportMenu_Buffs_Defensive_Options_Page1 =
                    {
                    }
                    local fieldSupportMenu_Buffs_Defensive_Options_Page2 =
                    {
                    }
                    local fieldSupportMenu_Buffs_Offensive_Options_Page1 =
                    {
                    }
                    local fieldSupportMenu_Buffs_Offensive_Options_Page2 =
                    {
                    }
                    local fieldSupportMenu_Buffs_Foods_Options_Page1 =
                    {
                    }
                    local fieldSupportMenu_Buffs_Foods_Options_Page2 =
                    {
                    }

                local fieldSupportConfirmMenu =  {} -- "Are you certain?"
                    -- Menu Options
                    local fieldSupportConfirmMenu_Options = {}
                    local regimeCancelConfirmMenu_Options = {}

                local regimeCancelConfirmMenu =  {} -- "Are you certain?"
                    local regimeCancelConfirmMenu_Options = {}

                -- Header
                local pageMenu = {} -- "Which Page"
                    local pageMenu_Options = {}
                        -- Menu Options
                        local page1 = {}
                        local page2 = {}
                        local page3 = {}
                        local page4 = {}
                        local page5 = {}
                        local page6 = {}

                    local pageMenu_Options_2 = {}
                        local page7 = {}
                        local page8 = {}
                        local page9 = {}
                        local page10 = {}
                        local page11 = {}
                        local page12 = {}

                -- Header
                local pageConfirmMenu = {} -- "Undertake this regime?"
                    -- Menu Options
                    local pageConfirmMenu_Options = {}
                -- Header
                local pageRepeatMenu = {} -- "Set this training regime to repeat?"
                    -- Menu Options
                    local pageRepeatMenu_Options = {}

                local prowessMenu =  {} -- "Are you certain?"
                    -- Menu Options
                    local prowessMenu_Options = {}

                local pageNum =
                {
                    { name = 'Page 1',  regimeId = 1,  zone = zoneID, var = page1  },
                    { name = 'Page 2',  regimeId = 2,  zone = zoneID, var = page2  },
                    { name = 'Page 3',  regimeId = 3,  zone = zoneID, var = page3  },
                    { name = 'Page 4',  regimeId = 4,  zone = zoneID, var = page4  },
                    { name = 'Page 5',  regimeId = 5,  zone = zoneID, var = page5  },
                    { name = 'Page 6',  regimeId = 6,  zone = zoneID, var = page6  },
                    { name = 'Page 7',  regimeId = 7,  zone = zoneID, var = page7  },
                    { name = 'Page 8',  regimeId = 8,  zone = zoneID, var = page8  },
                    { name = 'Page 9',  regimeId = 9,  zone = zoneID, var = page9  },
                    { name = 'Page 10', regimeId = 10, zone = zoneID, var = page10 },
                    { name = 'Page 11', regimeId = 11, zone = zoneID, var = page11 },
                    { name = 'Page 12', regimeId = 12, zone = zoneID, var = page12 },
                }

                -----------------------------------
                -- Dialog Helpers
                -----------------------------------
                local function displayObjectiveMessage(player, delay)
                    player:timer(delay, function(playerArg)
                        local regimeZone = playerArg:getLocalVar('[cactuarRegimes]zone')
                        local regimePage = playerArg:getLocalVar('[cactuarRegimes]regimeId')
                        local obj1_needed = playerArg:getLocalVar('[cactuarRegimes]needed1')
                        local obj2_needed = playerArg:getLocalVar('[cactuarRegimes]needed2')
                        local obj3_needed = playerArg:getLocalVar('[cactuarRegimes]needed3')
                        local obj4_needed = playerArg:getLocalVar('[cactuarRegimes]needed4')

                        local regimeZoneID = regimeZone
                        local regimeZoneData = xi.cactuarRegimes.zoneData[regimeZoneID]
                        local regimeTrainingData = regimeZoneData.trainingData[regimePage]

                        -- Only display messages if the objX_needed values are not nil or 0
                        if obj1_needed and obj1_needed > 0 then
                            playerArg:printToPlayer(string.format('%s %s', obj1_needed, regimeTrainingData.obj1Dialog), xi.msg.channel.SYSTEM_3)
                        end
                        if obj2_needed and obj2_needed > 0 then
                            playerArg:printToPlayer(string.format('%s %s', obj2_needed, regimeTrainingData.obj2Dialog), xi.msg.channel.SYSTEM_3)
                        end
                        if obj3_needed and obj3_needed > 0 then
                            playerArg:printToPlayer(string.format('%s %s', obj3_needed, regimeTrainingData.obj3Dialog), xi.msg.channel.SYSTEM_3)
                        end
                        if obj4_needed and obj4_needed > 0 then
                            playerArg:printToPlayer(string.format('%s %s', obj4_needed, regimeTrainingData.obj4Dialog), xi.msg.channel.SYSTEM_3)
                        end
                    end)
                end

                local function displayPageMessage(playerArg, delay, message)
                    playerArg:timer(delay, function(playerArg)
                        playerArg:printToPlayer(message, xi.msg.channel.SYSTEM_3)
                    end)
                end

                local delaySendMenu = function(player, menuHeader)
                    -- Update tabs dynamically before displaying menu
                    local tabs = player:getCurrency('valor_point')

                    -- Update fieldSupportMenu title with new tabs value
                    if menuHeader.title:find('Which ones?') then
                        menuHeader.title = string.format('Which ones? (You have %s tabs).', tabs)
                    end

                    if menuHeader.title:find('Which Catagory?') then
                        menuHeader.title = string.format('Which ones? (You have %s tabs).', tabs)
                    end

                    player:timer(50, function(playerArg)
                        playerArg:customMenu(menuHeader)
                    end)
                end

                -----------------------------------
                -- Menu Headers
                -----------------------------------

                mainMenu = {
                    title = 'What will you do?',
                    options = {}
                }

                fieldSupportCatagoryMenu = {
                    title = string.format('Which Catagory?'),
                    options = {}
                }

                fieldSupportMenu = {
                    title = string.format('Which ones?'),
                    options = {}
                }

                fieldSupportConfirmMenu = {
                    title = 'Are you certain?',
                    options = {}
                }

                regimeCancelConfirmMenu = {
                    title = 'Are you certain?',
                    options = {}
                }

                pageMenu = {
                    title = 'Which Page?',
                    options = {}
                }

                pageConfirmMenu = {
                    title = 'Undertake this training regime?',
                    options = {}
                }

                pageRepeatMenu = {
                    title = 'Set training regime to repeat?',
                    options = {}
                }

                -----------------------------------
                -- Main Menu
                -----------------------------------
                table.insert(mainMenu_Options, {
                    'Nothing.',
                    function(playerArg)
                    end,
                })
                if player:getCharVar('[cactuarRegimes]regimeId') > 0 then
                    table.insert(mainMenu_Options, {
                        'Review current training regime.',
                        function(playerArg)
                            local regimeZone  = playerArg:getCharVar('[cactuarRegimes]zone')
                            local regimePage  = playerArg:getCharVar('[cactuarRegimes]regimeId')
                            local obj1_killed = playerArg:getCharVar('[cactuarRegimes]killed1')
                            local obj2_killed = playerArg:getCharVar('[cactuarRegimes]killed2')
                            local obj3_killed = playerArg:getCharVar('[cactuarRegimes]killed3')
                            local obj4_killed = playerArg:getCharVar('[cactuarRegimes]killed4')
                            local obj1_needed = playerArg:getCharVar('[cactuarRegimes]needed1')
                            local obj2_needed = playerArg:getCharVar('[cactuarRegimes]needed2')
                            local obj3_needed = playerArg:getCharVar('[cactuarRegimes]needed3')
                            local obj4_needed = playerArg:getCharVar('[cactuarRegimes]needed4')
                            local pageRepeat  = playerArg:getCharVar('[cactuarRegimes]repeat')
                            local repeatString = ''

                            if pageRepeat == 0 then
                                repeatString = 'No'
                            elseif pageRepeat == 1 then
                                repeatString = 'Yes'
                            end

                            local regimeZoneID = regimeZone
                            local regimeZoneData = xi.cactuarRegimes.zoneData[regimeZoneID]
                            local regimeTrainingData = regimeZoneData.trainingData[regimePage]

                            playerArg:printToPlayer(string.format('Current Regime:'), xi.msg.channel.SYSTEM_3)
                            playerArg:printToPlayer(string.format('%s', regimeTrainingData.zoneDialog), xi.msg.channel.SYSTEM_3)
                            playerArg:printToPlayer(string.format('Training Regime: Page %i, Repeat: %s', regimePage, repeatString), xi.msg.channel.SYSTEM_3)
                            playerArg:printToPlayer(string.format('Base Reward: %s', regimeTrainingData.expReward), xi.msg.channel.SYSTEM_3)
                            playerArg:printToPlayer(string.format('Objective 1: %s/ %s %s.', obj1_killed, obj1_needed, regimeTrainingData.obj1Dialog), xi.msg.channel.SYSTEM_3)
                            if obj2_needed ~= 0 or nil then
                                playerArg:printToPlayer(string.format('Objective 2: %s/ %s %s.', obj2_killed, obj2_needed, regimeTrainingData.obj2Dialog), xi.msg.channel.SYSTEM_3)
                            end
                            if obj3_needed ~= 0 or nil then
                                playerArg:printToPlayer(string.format('Objective 3: %s/ %s %s.', obj3_killed, obj3_needed, regimeTrainingData.obj3Dialog), xi.msg.channel.SYSTEM_3)
                            end
                            if obj4_needed ~= 0 or nil then
                                playerArg:printToPlayer(string.format('Objective 4: %s/ %s %s.', obj4_killed, obj4_needed, regimeTrainingData.obj4Dialog), xi.msg.channel.SYSTEM_3)
                            end
                            mainMenu.options = mainMenu_Options
                            delaySendMenu(playerArg, mainMenu)
                        end,
                    })
                    table.insert(mainMenu_Options, {
                        'Cancel current training regime.',
                        function(playerArg)
                            -- playerArg:setLocalVar('[cactuarRegimes]regimeReset_Primer', 1)
                            regimeCancelConfirmMenu.options = regimeCancelConfirmMenu_Options
                            delaySendMenu(playerArg, regimeCancelConfirmMenu)
                        end,
                    })
                else
                    table.insert(mainMenu_Options, {
                        'Read about individual training.',
                        function(playerArg)
                            pageMenu.options = pageMenu_Options
                            delaySendMenu(playerArg, pageMenu)
                        end,
                    })
                end
                table.insert(mainMenu_Options, {
                    'Read about field support.',
                    function(playerArg)
                        fieldSupportCatagoryMenu.options = fieldSupportCatagoryMenu_Options
                        delaySendMenu(playerArg, fieldSupportCatagoryMenu)
                    end,
                })

                table.insert(mainMenu_Options, {
                    'Review active prowesses',
                    function(playerArg)
                        mainMenu.options = prowessMenu_Options
                        delaySendMenu(playerArg, mainMenu)
                    end,
                })

                -----------------------------------
                -- Regime Cancel Confirm Menu
                -----------------------------------
                table.insert(regimeCancelConfirmMenu_Options, {
                    'Yes',
                    function(playerArg)
                        playerArg:setLocalVar('[cactuarRegimes]regimeReset_Primer', 0)
                        playerArg:printToPlayer('Your current training regime has been cancelled.', xi.msg.channel.SYSTEM_3)
                        xi.cactuarRegimes.clearRegimeVars(player)
                    end,
                })

                table.insert(regimeCancelConfirmMenu_Options, {
                    'No',
                    function(playerArg)
                        mainMenu.options = mainMenu_Options
                        delaySendMenu(playerArg, mainMenu)
                    end,
                })

                -----------------------------------
                -- Prowess Options Menu
                -----------------------------------
                table.insert(prowessMenu_Options, {
                    'Previous Page',
                    function(playerArg)
                        mainMenu.options = mainMenu_Options
                        delaySendMenu(playerArg, mainMenu)
                    end,
                })
                table.insert(prowessMenu_Options, {
                    'Review active prowess effects',
                    function(playerArg)
                        local function printProwessEffect(player, effect, message, suffix)
                            if player:hasStatusEffect(effect) then
                                local power = player:getStatusEffect(effect):getPower()
                                player:printToPlayer(string.format(message, power, suffix or ''), xi.msg.channel.SYSTEM_3)
                            end
                        end

                        if playerArg:hasStatusEffect(xi.effect.PROWESS) then
                            local prowessPower  = playerArg:getStatusEffect(xi.effect.PROWESS):getPower()
                            local prowessZoneId = playerArg:getStatusEffect(xi.effect.PROWESS):getSubPower()
                            local zoneName      = getZoneNameByNumber(prowessZoneId)

                            playerArg:printToPlayer(string.format('Prowess Zone: %s', zoneName), xi.msg.channel.SYSTEM_3)
                            playerArg:printToPlayer(string.format('Prowess Rewards: +%i%s', prowessPower, '%'), xi.msg.channel.SYSTEM_3)

                            printProwessEffect(playerArg, xi.effect.PROWESS_WS_DMG       , 'Prowess Weaponskill DMG: +%i%s', '%')
                            printProwessEffect(playerArg, xi.effect.PROWESS_CRYSTAL_YIELD, 'Prowess Crystal Yields: +%i%s', '%')
                            printProwessEffect(playerArg, xi.effect.PROWESS_SKILL_RATE   , 'Prowess Skill Up Rate: +%i%s', '%')
                            printProwessEffect(playerArg, xi.effect.PROWESS_ATTACK_SPEED , 'Prowess Attack Speed: +%i%s', '%')
                            printProwessEffect(playerArg, xi.effect.PROWESS_CURE_POTENCY , 'Prowess Cure Potency: +%i%s', '%')
                            printProwessEffect(playerArg, xi.effect.PROWESS_CASKET_RATE  , 'Prowess Casket Rate: +%i%s', '%')
                            printProwessEffect(playerArg, xi.effect.PROWESS_TH           , 'Prowess Treasure Hunter: +%i')
                            printProwessEffect(playerArg, xi.effect.PROWESS_KILLER       , 'Prowess Killer Effect: +%i')
                            printProwessEffect(playerArg, xi.effect.PROWESS_MACC_MATK    , 'Prowess MACC/MATT: +%i')
                            printProwessEffect(playerArg, xi.effect.PROWESS_ACC_RACC     , 'Prowess ACC/RACC: +%i')
                            printProwessEffect(playerArg, xi.effect.PROWESS_ATT_RATT     , 'Prowess ATT/RATT: +%i')
                            printProwessEffect(playerArg, xi.effect.PROWESS_HP_MP        , 'Prowess HP/MP: +%i')
                        else
                            playerArg:printToPlayer('You have no active prowess effects', xi.msg.channel.SYSTEM_3)
                        end
                        mainMenu.options = prowessMenu_Options
                        delaySendMenu(playerArg, mainMenu)
                    end,
                })

                table.insert(prowessMenu_Options, {
                    'Reset current prowess progress',
                    function(playerArg)
                        if not player:hasStatusEffect(xi.effect.PROWESS) then
                            playerArg:printToPlayer('You have no active prowess effects', xi.msg.channel.SYSTEM_3)
                            mainMenu.options = mainMenu_Options
                            delaySendMenu(playerArg, mainMenu)
                        else
                            playerArg:setLocalVar('[cactuarRegimes]Prowess_Reset', 1)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        end
                    end,
                })

                -----------------------------------
                -- Field Support Catagory Menu
                -----------------------------------
                table.insert(fieldSupportCatagoryMenu_Options, {
                    'Nothing for now.',
                    function(playerArg)
                        mainMenu.options = mainMenu_Options
                        delaySendMenu(playerArg, mainMenu)
                    end,
                })
                table.insert(fieldSupportCatagoryMenu_Options, {
                    'Repatriation (75)',
                    function(playerArg)
                        player:setLocalVar('[cactuarRegimes]Buff_Warp', 1)
                        fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                        delaySendMenu(playerArg, fieldSupportConfirmMenu)
                    end,
                })
                table.insert(fieldSupportCatagoryMenu_Options, {
                    'Circumspection (30)',
                    function(playerArg)
                        player:setLocalVar('[cactuarRegimes]Buff_Circumspection', 1)
                        fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                        delaySendMenu(playerArg, fieldSupportConfirmMenu)
                    end,
                })
                table.insert(fieldSupportCatagoryMenu_Options, {
                    'Defensive Buffs',
                    function(playerArg)
                        fieldSupportMenu.options = fieldSupportMenu_Buffs_Defensive_Options_Page1
                        delaySendMenu(playerArg, fieldSupportMenu)
                    end,
                })
                table.insert(fieldSupportCatagoryMenu_Options, {
                    'Offensive Buffs',
                    function(playerArg)
                        fieldSupportMenu.options = fieldSupportMenu_Buffs_Offensive_Options_Page1
                        delaySendMenu(playerArg, fieldSupportMenu)
                    end,
                })
                table.insert(fieldSupportCatagoryMenu_Options, {
                    'Foods',
                    function(playerArg)
                        fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page1
                        delaySendMenu(playerArg, fieldSupportMenu)
                    end,
                })

                -----------------------------------
                -- Field Support Menu Defensive Buffs
                -----------------------------------
                table.insert(fieldSupportMenu_Buffs_Defensive_Options_Page1, {
                    'Previous Page',
                    function(playerArg)
                        fieldSupportCatagoryMenu.options = fieldSupportCatagoryMenu_Options
                        delaySendMenu(playerArg, fieldSupportCatagoryMenu)
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Defensive_Options_Page1,
                {
                    'Reraise (100)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.RERAISE) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Reraise', 1)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:printToPlayer('You have already have this buff active', xi.msg.channel.SYSTEM_3)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Defensive_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })

                table.insert(fieldSupportMenu_Buffs_Defensive_Options_Page1, {
                    'Regen (15 ~ 50)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.REGEN) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Regen', 1)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:printToPlayer('You have already have this buff active', xi.msg.channel.SYSTEM_3)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Defensive_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Defensive_Options_Page1, {
                    'Refresh (15 ~ 45)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.REFRESH) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Refresh', 1)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:printToPlayer('You have already have this buff active', xi.msg.channel.SYSTEM_3)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Defensive_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })

                table.insert(fieldSupportMenu_Buffs_Defensive_Options_Page1, {
                    'Protect (15 ~ 50)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.PROTECT) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Protect', 1)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:printToPlayer('You have already have this buff active', xi.msg.channel.SYSTEM_3)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Defensive_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })

                table.insert(fieldSupportMenu_Buffs_Defensive_Options_Page1, {
                    'Shell (15 ~ 50)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.SHELL) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Shell', 1)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:printToPlayer('You have already have this buff active', xi.msg.channel.SYSTEM_3)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Defensive_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Defensive_Options_Page1, {
                    'Next Page',
                    function(playerArg)
                        fieldSupportMenu.options = fieldSupportMenu_Buffs_Defensive_Options_Page2
                        delaySendMenu(playerArg, fieldSupportMenu)
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Defensive_Options_Page2, {
                    'Previous Page',
                    function(playerArg)
                        fieldSupportMenu.options = fieldSupportMenu_Buffs_Defensive_Options_Page1
                        delaySendMenu(playerArg, fieldSupportMenu)
                    end,
                })
                -----------------------------------
                -- Field Support Menu Offensive Buffs
                -----------------------------------
                table.insert(fieldSupportMenu_Buffs_Offensive_Options_Page1, {
                    'Previous Page',
                    function(playerArg)
                        fieldSupportCatagoryMenu.options = fieldSupportCatagoryMenu_Options
                        delaySendMenu(playerArg, fieldSupportCatagoryMenu)
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Offensive_Options_Page1, {
                    'Haste (50)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.HASTE) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Haste', 1)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:printToPlayer('You have already have this buff active', xi.msg.channel.SYSTEM_3)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Offensive_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Offensive_Options_Page1, {
                    'Flurry (50)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.FLURRY) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Flurry', 1)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:printToPlayer('You have already have this buff active', xi.msg.channel.SYSTEM_3)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Offensive_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })

                -----------------------------------
                -- Field Support Menu Defensive Buffs
                -----------------------------------
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page1, {
                    'Previous Page',
                    function(playerArg)
                        fieldSupportCatagoryMenu.options = fieldSupportCatagoryMenu_Options
                        delaySendMenu(playerArg, fieldSupportCatagoryMenu)
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page1, {
                    'Dried Meat (75)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.FOOD) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Food', 1)
                            playerArg:printToPlayer('Dried Meat: STR +4, ATT +22% (Cap 63)', xi.msg.channel.SYSTEM_3)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:messageBasic(xi.msg.basic.IS_FULL)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page1, {
                    'Salted Fish (75)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.FOOD) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Food', 2)
                            playerArg:printToPlayer('Salted Fish: VIT +2, DEF +30% (Cap 86)', xi.msg.channel.SYSTEM_3)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:messageBasic(xi.msg.basic.IS_FULL)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page1,
                {
                    'Hard Cookie (75)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.FOOD) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Food', 3)
                            playerArg:printToPlayer('Hard Cookie: INT +4, MP +30', xi.msg.channel.SYSTEM_3)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:messageBasic(xi.msg.basic.IS_FULL)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page1, {
                    'Instant Noodles (75)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.FOOD) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Food', 4)
                            playerArg:printToPlayer('Instant Noodles: VIT +1, Store TP +5, HP +27% (Cap 75)', xi.msg.channel.SYSTEM_3)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:messageBasic(xi.msg.basic.IS_FULL)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page1, {
                    'Next Page',
                    function(playerArg)
                        fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page2
                        delaySendMenu(playerArg, fieldSupportMenu)
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page2, {
                    'Dried Agaricus (75)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.FOOD) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Food', 5)
                            playerArg:printToPlayer('Dried Agaricus: MND +4, MP +2~76, hMP +2', xi.msg.channel.SYSTEM_3)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:messageBasic(xi.msg.basic.IS_FULL)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page2, {
                    'Instant Rice (75)',
                    function(playerArg)
                        if not playerArg:hasStatusEffect(xi.effect.FOOD) then
                            playerArg:setLocalVar('[cactuarRegimes]Buff_Food', 6)
                            playerArg:printToPlayer('Instant Rice: CHR +6, HP +35, hHP +3', xi.msg.channel.SYSTEM_3)
                            fieldSupportConfirmMenu.options = fieldSupportConfirmMenu_Options
                            delaySendMenu(playerArg, fieldSupportConfirmMenu)
                        else
                            playerArg:messageBasic(xi.msg.basic.IS_FULL)
                            fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page1
                            delaySendMenu(playerArg, fieldSupportMenu)
                        end
                    end,
                })
                table.insert(fieldSupportMenu_Buffs_Foods_Options_Page2, {
                    'Previous Page',
                    function(playerArg)
                        fieldSupportMenu.options = fieldSupportMenu_Buffs_Foods_Options_Page1
                        delaySendMenu(playerArg, fieldSupportMenu)
                    end,
                })

                -----------------------------------
                -- Field Support Confirm Menu
                -----------------------------------
                table.insert(fieldSupportConfirmMenu_Options, {
                    'Yes',
                    function(playerArg)
                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Warp') == 1 then
                            playerArg:delCurrency('valor_point', 75)
                            playerArg:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.HOME_NATION, 0, 3)
                            npc:injectActionPacket(playerArg:getID(), 4, 261, 0, 0, 0, 10, 1)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Circumspection') == 1 then
                            npc:injectActionPacket(playerArg:getID(), 4, 498, 0, 0, 0, 10, 1)
                            playerArg:delStatusEffectSilent(xi.effect.SNEAK)
                            playerArg:addStatusEffect(xi.effect.SNEAK, 0, 10, 300 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER)
                            playerArg:delStatusEffectSilent(xi.effect.INVISIBLE)
                            playerArg:addStatusEffect(xi.effect.INVISIBLE, 0, 10, 300 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER)
                            playerArg:delCurrency('valor_point', 30)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Reraise') == 1 then
                            playerArg:delCurrency('valor_point', 100)
                            npc:injectActionPacket(playerArg:getID(), 4, 137, 0, 0, 0, 10, 1)
                            playerArg:delStatusEffectSilent(xi.effect.RERAISE)
                            playerArg:addStatusEffect(xi.effect.RERAISE, 1, 0, 7200)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Regen') == 1 then
                            local mLvl = playerArg:getMainLvl()
                            local power = 0
                            local cost = 0

                            if mLvl >= 1 and mLvl <= 10 then
                                power = 1
                                cost  = 15
                            elseif mLvl >= 11 and mLvl <= 20 then
                                power = 2
                                cost  = 20
                            elseif mLvl > 21 and mLvl <= 30 then
                                power = 3
                                cost  = 25
                            elseif mLvl > 31 and mLvl <= 40 then
                                power = 4
                                cost  = 30
                            elseif mLvl > 41 and mLvl <= 50 then
                                power = 5
                                cost  = 35
                            elseif mLvl > 51 and mLvl <= 60 then
                                power = 6
                                cost  = 40
                            elseif mLvl > 61 and mLvl <= 70 then
                                power = 7
                                cost  = 45
                            elseif mLvl > 71 and mLvl <= 75 then
                                power = 8
                                cost  = 50
                            else
                                power = 50
                            end

                            npc:injectActionPacket(playerArg:getID(), 4, 108, 0, 0, 0, 10, 1)
                            playerArg:delStatusEffectSilent(xi.effect.REGEN)
                            playerArg:addStatusEffect(xi.effect.REGEN, power, 3, 1800)
                            playerArg:delCurrency('valor_point', cost)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Refresh') == 1 then
                            local mLvl = playerArg:getMainLvl()
                            local power = 0
                            local cost  = 0

                            if mLvl >= 1 and mLvl <= 20 then
                                power = 1
                                cost  = 15
                            elseif mLvl >= 21 and mLvl <= 40 then
                                power = 2
                                cost  = 30
                            else
                                power = 3
                                cost  = 45
                            end
                            npc:injectActionPacket(playerArg:getID(), 4, 109, 0, 0, 0, 10, 1)
                            playerArg:delStatusEffectSilent(xi.effect.REFRESH)
                            playerArg:delStatusEffect(xi.effect.SUBLIMATION_COMPLETE)
                            playerArg:delStatusEffect(xi.effect.SUBLIMATION_ACTIVATED)
                            playerArg:addStatusEffect(xi.effect.REFRESH, power, 3, 1800, 0, 3)
                            playerArg:delCurrency('valor_point', cost)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Protect') == 1 then
                            local mLvl  = playerArg:getMainLvl()
                            local power = 220
                            local tier  = 5
                            local cost  = 0

                            if mLvl < 25 then
                                power = 20 -- Protect I
                                tier  = 1
                                cost  = 15
                            elseif mLvl < 45 then
                                power = 50 -- Protect II
                                tier  = 2
                                cost  = 25
                            elseif mLvl < 65 then
                                power = 90 -- Protect III
                                tier  = 3
                                cost  = 35
                            elseif mLvl < 76 then
                                power = 140 -- Protect IV
                                tier  = 4
                                cost  = 50
                            end

                            local bonus = 0
                            if playerArg:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
                                local modifier = playerArg:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD)
                                bonus = modifier * 2
                            end

                            power = power + (bonus * tier)
                            npc:injectActionPacket(playerArg:getID(), 4, (42 + tier), 0, 0, 0, 10, 1)
                            playerArg:delStatusEffectSilent(xi.effect.PROTECT)
                            playerArg:addStatusEffect(xi.effect.PROTECT, power, 0, 1800, 0, 0, tier)
                            playerArg:delCurrency('valor_point', cost)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Shell') == 1 then
                            local mLvl  = playerArg:getMainLvl()

                            -- Shell V (75/256)
                            local power = 2930
                            local tier  = 5
                            local cost  = 0

                            if mLvl < 37 then
                                power = 1055 -- Shell I   (27/256)
                                tier = 1
                                cost = 15

                            elseif mLvl < 57 then
                                power = 1641 -- Shell II  (42/256)
                                tier = 2
                                cost = 25
                            elseif mLvl < 68 then
                                power = 2188 -- Shell III (56/256)
                                tier = 3
                                cost = 35
                            elseif mLvl < 76 then
                                power = 2617 -- Shell IV  (67/256)
                                tier = 4
                                cost = 50
                            end

                            local bonus = 0
                            if playerArg:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
                                local modifier = playerArg:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD)
                                bonus = 39 * modifier   -- (1/256 bonus buff per tier of spell)
                            end

                            power = power + (bonus * tier)
                            npc:injectActionPacket(playerArg:getID(), 4, (47 + tier), 0, 0, 0, 10, 1)
                            playerArg:delStatusEffectSilent(xi.effect.SHELL)
                            playerArg:addStatusEffect(xi.effect.SHELL, power, 0, 1800, 0, 0, tier)
                            playerArg:delCurrency('valor_point', cost)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Haste') == 1 then
                            npc:injectActionPacket(playerArg:getID(), 4, 57, 0, 0, 0, 10, 1)
                            playerArg:delStatusEffectSilent(xi.effect.HASTE)
                            playerArg:addStatusEffect(xi.effect.HASTE, 1000, 0, 1800)
                            playerArg:delCurrency('valor_point', 50)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Flurry') == 1 then
                            playerArg:delCurrency('valor_point', 30)
                            npc:injectActionPacket(playerArg:getID(), 4, 931, 0, 0, 0, 10, 1)
                            playerArg:delStatusEffectSilent(xi.effect.FLURRY_II)
                            playerArg:addStatusEffect(xi.effect.FLURRY_II, 15, 0, 1800)
                            playerArg:delCurrency('valor_point', 50)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Buff_Food') >= 1 then
                            local power = playerArg:getLocalVar('[cactuarRegimes]Buff_Food')
                            local effectAnim = 0
                            if
                                power == 1 or
                                power == 4
                            then
                                effectAnim = 28
                            elseif
                                power == 2 or
                                power == 6
                            then
                                effectAnim = 25
                            elseif power == 3 then
                                effectAnim = 29
                            elseif power == 5 then
                                effectAnim = 27
                            end
                            npc:sendNpcEmote(player, xi.emote.TOSS, xi.emoteMode.MOTION)
                            playerArg:timer(1500, function(playerArg)
                                playerArg:addStatusEffect(xi.effect.FOOD, power, 0, 1800, 0)
                                playerArg:injectActionPacket(playerArg:getID(), 5, effectAnim, 0, 0, 0, 10, 1)
                                playerArg:delCurrency('valor_point', 75)
                            end)
                        end

                        if playerArg:getLocalVar('[cactuarRegimes]Prowess_Reset') == 1 then
                            delProwessEffect(playerArg, xi.effect.PROWESS)
                            delProwessEffect(playerArg, xi.effect.PROWESS_CASKET_RATE)
                            delProwessEffect(playerArg, xi.effect.PROWESS_SKILL_RATE)
                            delProwessEffect(playerArg, xi.effect.PROWESS_CRYSTAL_YIELD)
                            delProwessEffect(playerArg, xi.effect.PROWESS_TH)
                            delProwessEffect(playerArg, xi.effect.PROWESS_ATTACK_SPEED)
                            delProwessEffect(playerArg, xi.effect.PROWESS_HP_MP)
                            delProwessEffect(playerArg, xi.effect.PROWESS_ACC_RACC)
                            delProwessEffect(playerArg, xi.effect.PROWESS_ATT_RATT)
                            delProwessEffect(playerArg, xi.effect.PROWESS_MACC_MATK)
                            delProwessEffect(playerArg, xi.effect.PROWESS_CURE_POTENCY)
                            delProwessEffect(playerArg, xi.effect.PROWESS_WS_DMG)
                            delProwessEffect(playerArg, xi.effect.PROWESS_KILLER)
                            playerArg:printToPlayer('Prowess progress has been reset.', xi.msg.channel.SYSTEM_3)
                        end
                        playerArg:setLocalVar('[cactuarRegimes]Prowess_Reset', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Warp', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Circumspection', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Reraise', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Regen', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Refresh', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Protect', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Shell', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Haste', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Flurry', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Food', 0)
                        fieldSupportMenu.options = fieldSupportCatagoryMenu_Options
                        delaySendMenu(playerArg, fieldSupportMenu)
                    end,
                })
                table.insert(fieldSupportConfirmMenu_Options, {
                    'No',
                    function(playerArg)
                        playerArg:setLocalVar('[cactuarRegimes]Prowess_Reset', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Warp', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Circumspection', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Reraise', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Regen', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Refresh', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Protect', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Shell', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Haste', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Flurry', 0)
                        playerArg:setLocalVar('[cactuarRegimes]Buff_Food', 0)
                        mainMenu.options = mainMenu_Options
                        delaySendMenu(playerArg, mainMenu)
                    end,
                })
                -----------------------------------
                -- Page selection menu
                -----------------------------------
                -- Go back to main menu
                table.insert(pageMenu_Options, {
                    'I\'ve changed my mind.',
                    function(playerArg)
                        mainMenu.options = mainMenu_Options
                        delaySendMenu(playerArg, mainMenu)
                    end})

                -- List of pages player can accept.
                -- Automatically populates pages based on zone data.
                -- for i = 1, #zoneData.trainingData do
                for i = 1, math.min(#zoneData.trainingData, 6) do
                    local v = pageNum[i]
                    local pageDialogs =
                    {
                        zoneData.trainingData[i].lvlRangeDialog,
                        'Base Reward: ' .. zoneData.trainingData[i].expReward,
                        zoneData.trainingData[i].zoneDialog,
                    }

                    table.insert(pageMenu_Options, {v.name, function(playerArg)
                        -- Store player selection as a local var to reference for confirmation page
                        playerArg:setLocalVar('[cactuarRegimes]zone', v.zone)
                        playerArg:setLocalVar('[cactuarRegimes]regimeId', v.regimeId)
                        playerArg:setLocalVar('[cactuarRegimes]needed1', zoneData.trainingData[i].obj1_count)
                        playerArg:setLocalVar('[cactuarRegimes]needed2', zoneData.trainingData[i].obj2_count)
                        playerArg:setLocalVar('[cactuarRegimes]needed3', zoneData.trainingData[i].obj3_count)
                        playerArg:setLocalVar('[cactuarRegimes]needed4', zoneData.trainingData[i].obj4_count)

                        local regimeZone = playerArg:getLocalVar('[cactuarRegimes]zone')
                        local regimePage = playerArg:getLocalVar('[cactuarRegimes]regimeId')
                        local obj1_needed = playerArg:getLocalVar('[cactuarRegimes]needed1')
                        local obj2_needed = playerArg:getLocalVar('[cactuarRegimes]needed2')
                        local obj3_needed = playerArg:getLocalVar('[cactuarRegimes]needed3')
                        local obj4_needed = playerArg:getLocalVar('[cactuarRegimes]needed4')

                        local regimeZoneID = regimeZone
                        local regimeZoneData = xi.cactuarRegimes.zoneData[regimeZoneID]
                        local regimeTrainingData = regimeZoneData.trainingData[regimePage]

                        -- Delay settings
                        local initialDelay   = 2000  -- Initial delay for the first message
                        local delayIncrement = 1000  -- Delay increment between messages
                        local currentDelay   = initialDelay

                        playerArg:timer(500, function(playerArg)
                            playerArg:printToPlayer('The information on this page instructs you to defeat the following:', xi.msg.channel.SYSTEM_3)
                        end)

                        -- Only display messages if the objX_needed values are not nil or 0
                        if obj1_needed and obj1_needed > 0 then
                            playerArg:timer(currentDelay, function(playerArg)
                                playerArg:printToPlayer(string.format('%s %s', obj1_needed, regimeTrainingData.obj1Dialog), xi.msg.channel.SYSTEM_3)
                            end)
                            currentDelay = currentDelay + delayIncrement
                        end
                        if obj2_needed and obj2_needed > 0 then
                            playerArg:timer(currentDelay, function(playerArg)
                                playerArg:printToPlayer(string.format('%s %s', obj2_needed, regimeTrainingData.obj2Dialog), xi.msg.channel.SYSTEM_3)
                            end)
                            currentDelay = currentDelay + delayIncrement
                        end
                        if obj3_needed and obj3_needed > 0 then
                            playerArg:timer(currentDelay, function(playerArg)
                                playerArg:printToPlayer(string.format('%s %s', obj3_needed, regimeTrainingData.obj3Dialog), xi.msg.channel.SYSTEM_3)
                            end)
                            currentDelay = currentDelay + delayIncrement
                        end
                        if obj4_needed and obj4_needed > 0 then
                            playerArg:timer(currentDelay, function(playerArg)
                                playerArg:printToPlayer(string.format('%s %s', obj4_needed, regimeTrainingData.obj4Dialog), xi.msg.channel.SYSTEM_3)
                            end)
                            currentDelay = currentDelay + delayIncrement
                        end

                        for _, message2 in ipairs(pageDialogs) do
                            if message2 then  -- Skip if message is nil
                                displayPageMessage(playerArg, currentDelay, message2)
                                currentDelay = currentDelay + delayIncrement  -- Increment delay only if message exists
                            end
                        end

                        local finalDelay = currentDelay + 500
                        currentDelay = initialDelay
                        playerArg:timer(finalDelay, function(playerArg)
                            pageConfirmMenu.options = pageConfirmMenu_Options
                            delaySendMenu(playerArg, pageConfirmMenu)
                        end)
                    end})
                end

                -- Go back to main menu
                table.insert(pageMenu_Options, {
                    'Next Page',
                    function(playerArg)
                        pageMenu.options = pageMenu_Options_2
                        delaySendMenu(playerArg, pageMenu)
                    end})

                -----------------------------------
                -- Page selection menu (Page 2)
                -----------------------------------
                -- Go back to main menu
                table.insert(pageMenu_Options_2, {
                    'Previous Page',
                    function(playerArg)
                        pageMenu.options = pageMenu_Options
                        delaySendMenu(playerArg, pageMenu)
                    end})

                -- List of pages player can accept.
                -- Automatically populates pages based on zone data.
                for i = 7, math.min(#zoneData.trainingData, 12) do
                    local v = pageNum[i]
                    local pageDialogs =
                    {
                        zoneData.trainingData[i].lvlRangeDialog,
                        'Base Reward: ' .. zoneData.trainingData[i].expReward,
                        zoneData.trainingData[i].zoneDialog,
                    }

                    table.insert(pageMenu_Options_2, {v.name, function(playerArg)
                        -- Store player selection as a local var to reference for confirmation page
                        playerArg:setLocalVar('[cactuarRegimes]zone', v.zone)
                        playerArg:setLocalVar('[cactuarRegimes]regimeId', v.regimeId)
                        playerArg:setLocalVar('[cactuarRegimes]needed1', zoneData.trainingData[i].obj1_count)
                        playerArg:setLocalVar('[cactuarRegimes]needed2', zoneData.trainingData[i].obj2_count)
                        playerArg:setLocalVar('[cactuarRegimes]needed3', zoneData.trainingData[i].obj3_count)
                        playerArg:setLocalVar('[cactuarRegimes]needed4', zoneData.trainingData[i].obj4_count)

                        local regimeZone = playerArg:getLocalVar('[cactuarRegimes]zone')
                        local regimePage = playerArg:getLocalVar('[cactuarRegimes]regimeId')
                        local obj1_needed = playerArg:getLocalVar('[cactuarRegimes]needed1')
                        local obj2_needed = playerArg:getLocalVar('[cactuarRegimes]needed2')
                        local obj3_needed = playerArg:getLocalVar('[cactuarRegimes]needed3')
                        local obj4_needed = playerArg:getLocalVar('[cactuarRegimes]needed4')

                        local regimeZoneID = regimeZone
                        local regimeZoneData = xi.cactuarRegimes.zoneData[regimeZoneID]
                        local regimeTrainingData = regimeZoneData.trainingData[regimePage]

                        -- Delay settings
                        local initialDelay   = 2000  -- Initial delay for the first message
                        local delayIncrement = 1000  -- Delay increment between messages
                        local currentDelay   = initialDelay

                        playerArg:timer(500, function(playerArg)
                            playerArg:printToPlayer('The information on this page instructs you to defeat the following:', xi.msg.channel.SYSTEM_3)
                        end)

                        -- Only display messages if the objX_needed values are not nil or 0
                        if obj1_needed and obj1_needed > 0 then
                            playerArg:timer(currentDelay, function(playerArg)
                                playerArg:printToPlayer(string.format('%s %s', obj1_needed, regimeTrainingData.obj1Dialog), xi.msg.channel.SYSTEM_3)
                            end)
                            currentDelay = currentDelay + delayIncrement
                        end
                        if obj2_needed and obj2_needed > 0 then
                            playerArg:timer(currentDelay, function(playerArg)
                                playerArg:printToPlayer(string.format('%s %s', obj2_needed, regimeTrainingData.obj2Dialog), xi.msg.channel.SYSTEM_3)
                            end)
                            currentDelay = currentDelay + delayIncrement
                        end
                        if obj3_needed and obj3_needed > 0 then
                            playerArg:timer(currentDelay, function(playerArg)
                                playerArg:printToPlayer(string.format('%s %s', obj3_needed, regimeTrainingData.obj3Dialog), xi.msg.channel.SYSTEM_3)
                            end)
                            currentDelay = currentDelay + delayIncrement
                        end
                        if obj4_needed and obj4_needed > 0 then
                            playerArg:timer(currentDelay, function(playerArg)
                                playerArg:printToPlayer(string.format('%s %s', obj4_needed, regimeTrainingData.obj4Dialog), xi.msg.channel.SYSTEM_3)
                            end)
                            currentDelay = currentDelay + delayIncrement
                        end

                        for _, message2 in ipairs(pageDialogs) do
                            if message2 then  -- Skip if message is nil
                                displayPageMessage(playerArg, currentDelay, message2)
                                currentDelay = currentDelay + delayIncrement  -- Increment delay only if message exists
                            end
                        end

                        local finalDelay = currentDelay + 500
                        currentDelay = initialDelay
                        playerArg:timer(finalDelay, function(playerArg)
                            pageConfirmMenu.options = pageConfirmMenu_Options
                            delaySendMenu(playerArg, pageConfirmMenu)
                        end)
                    end})
                end

                -----------------------------------
                -- Page Confirmation Menu
                -----------------------------------
                table.insert(pageConfirmMenu_Options, {
                    'Bring it on!',
                    function(playerArg)
                        local regimeZone  = player:getLocalVar('[cactuarRegimes]zone')
                        local regimeId    = player:getLocalVar('[cactuarRegimes]regimeId')
                        local regimeObj1  = player:getLocalVar('[cactuarRegimes]needed1')
                        local regimeObj2  = player:getLocalVar('[cactuarRegimes]needed2')
                        local regimeObj3  = player:getLocalVar('[cactuarRegimes]needed3')
                        local regimeObj4  = player:getLocalVar('[cactuarRegimes]needed4')

                        playerArg:setCharVar('[cactuarRegimes]zone', regimeZone)
                        playerArg:setCharVar('[cactuarRegimes]regimeId', regimeId)
                        playerArg:setCharVar('[cactuarRegimes]needed1', regimeObj1)
                        playerArg:setCharVar('[cactuarRegimes]needed2', regimeObj2)
                        playerArg:setCharVar('[cactuarRegimes]needed3', regimeObj3)
                        playerArg:setCharVar('[cactuarRegimes]needed4', regimeObj4)

                        pageRepeatMenu.options = pageRepeatMenu_Options
                        delaySendMenu(playerArg, pageRepeatMenu)
                    end,
                })
                table.insert(pageConfirmMenu_Options, {
                    'No, Wait...',
                    function(playerArg)
                        playerArg:setCharVar('[cactuarRegimes]zone', 0)
                        playerArg:setCharVar('[cactuarRegimes]regimeId', 0)
                        pageMenu.options = pageMenu_Options
                        delaySendMenu(playerArg, pageMenu)
                    end,
                })

                -----------------------------------
                -- Page Repeat Menu
                -----------------------------------
                table.insert(pageRepeatMenu_Options, {
                    'Yes',
                    function(playerArg)
                        local regimeZone  = player:getLocalVar('[cactuarRegimes]zone')
                        local regimeId    = player:getLocalVar('[cactuarRegimes]regimeId')
                        local regimeObj1  = player:getLocalVar('[cactuarRegimes]needed1')
                        local regimeObj2  = player:getLocalVar('[cactuarRegimes]needed2')
                        local regimeObj3  = player:getLocalVar('[cactuarRegimes]needed3')
                        local regimeObj4  = player:getLocalVar('[cactuarRegimes]needed4')

                        playerArg:setCharVar('[cactuarRegimes]zone', regimeZone)
                        playerArg:setCharVar('[cactuarRegimes]regimeId', regimeId)
                        playerArg:setCharVar('[cactuarRegimes]needed1', regimeObj1)
                        playerArg:setCharVar('[cactuarRegimes]needed2', regimeObj2)
                        playerArg:setCharVar('[cactuarRegimes]needed3', regimeObj3)
                        playerArg:setCharVar('[cactuarRegimes]needed4', regimeObj4)

                        playerArg:setCharVar('[cactuarRegimes]repeat', 1)
                        playerArg:printToPlayer('New training regime registered! Repeating: YES', xi.msg.channel.SYSTEM_3)
                    end,
                })
                table.insert(pageRepeatMenu_Options, {
                    'No.',
                    function(playerArg)
                        local regimeZone  = player:getLocalVar('[cactuarRegimes]zone')
                        local regimeId    = player:getLocalVar('[cactuarRegimes]regimeId')
                        local regimeObj1  = player:getLocalVar('[cactuarRegimes]needed1')
                        local regimeObj2  = player:getLocalVar('[cactuarRegimes]needed2')
                        local regimeObj3  = player:getLocalVar('[cactuarRegimes]needed3')
                        local regimeObj4  = player:getLocalVar('[cactuarRegimes]needed4')

                        playerArg:setCharVar('[cactuarRegimes]zone', regimeZone)
                        playerArg:setCharVar('[cactuarRegimes]regimeId', regimeId)
                        playerArg:setCharVar('[cactuarRegimes]needed1', regimeObj1)
                        playerArg:setCharVar('[cactuarRegimes]needed2', regimeObj2)
                        playerArg:setCharVar('[cactuarRegimes]needed3', regimeObj3)
                        playerArg:setCharVar('[cactuarRegimes]needed4', regimeObj4)

                        playerArg:printToPlayer('New training regime registered! Repeating: NO', xi.msg.channel.SYSTEM_3)
                        playerArg:setCharVar('[cactuarRegimes]repeat', 0)

                    end,
                })

                -- npc:facePlayer(player)
                player:setLocalVar('[cactuarRegimes]Prowess_Reset', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Warp', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Circumspection', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Reraise', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Regen', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Refresh', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Protect', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Shell', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Haste', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Flurry', 0)
                player:setLocalVar('[cactuarRegimes]Buff_Food', 0)
                mainMenu.options = mainMenu_Options
                delaySendMenu(player, mainMenu)
            end
        })
    end
end

-- function made global to be called by hunts.lua
xi.cactuarRegimes.clearRegimeVars = function(player)
    player:setCharVar('[cactuarRegimes]type', 0) -- Grounds or FoV
    player:setCharVar('[cactuarRegimes]zone', 0)
    player:setCharVar('[cactuarRegimes]regimeId', 0)
    player:setCharVar('[cactuarRegimes]repeat', 0)
    player:setCharVar('[cactuarRegimes]lastReward', 0)
    player:setCharVar('[cactuarRegimes]avgMobLevel', 0)

    for i = 1, 4 do
        player:setCharVar('[cactuarRegimes]needed' .. i, 0)
        player:setCharVar('[cactuarRegimes]killed' .. i, 0)
    end
end

-- first time an effect is applied, use basePower
-- each additional time an effect is applied, use addPower
-- can stack each effect up to maxStack times, per https://ffxiclopedia.fandom.com/wiki/Grounds_of_Valor#Prowesses
local prowessData =
{
    { effect = xi.effect.PROWESS_CASKET_RATE,   basePower = 4,   addPower = 4,   maxStack = 5  },
    { effect = xi.effect.PROWESS_SKILL_RATE,    basePower = 4,   addPower = 2,   maxStack = 11 },
    { effect = xi.effect.PROWESS_CRYSTAL_YIELD, basePower = 4,   addPower = 4,   maxStack = 5  },
    { effect = xi.effect.PROWESS_TH,            basePower = 1,   addPower = 1,   maxStack = 3  },
    { effect = xi.effect.PROWESS_ATTACK_SPEED,  basePower = 400, addPower = 400, maxStack = 4  },
    { effect = xi.effect.PROWESS_HP_MP,         basePower = 3,   addPower = 1,   maxStack = 11 },
    { effect = xi.effect.PROWESS_ACC_RACC,      basePower = 3,   addPower = 3,   maxStack = 11 },
    { effect = xi.effect.PROWESS_ATT_RATT,      basePower = 5,   addPower = 3,   maxStack = 11 },
    { effect = xi.effect.PROWESS_MACC_MATK,     basePower = 3,   addPower = 2,   maxStack = 10 },
    { effect = xi.effect.PROWESS_CURE_POTENCY,  basePower = 4,   addPower = 4,   maxStack = 5  },
    { effect = xi.effect.PROWESS_WS_DMG,        basePower = 1,   addPower = 1,   maxStack = 5  },
    { effect = xi.effect.PROWESS_KILLER,        basePower = 1,   addPower = 1,   maxStack = 2  },
}

local function addGovProwessBonusEffect(player)
    -- make a table of prowesses that are not yet maxed
    local availableProwesses = {}
    local zoneId = player:getZoneID()

    for i = 1, #prowessData do
        local p = prowessData[i]
        local e = player:getStatusEffect(p.effect)

        if not e or e:getPower() < (p.basePower + p.addPower * (p.maxStack - 1)) then
            table.insert(availableProwesses, p)
        end
    end

    -- pick one and apply
    if #availableProwesses > 0 then
        local p = availableProwesses[math.random(1, #availableProwesses)]
        local e = player:getStatusEffect(p.effect)

        -- get current power
        local power = 0
        if e then
            power = e:getPower()
            player:delStatusEffectSilent(p.effect)
        end

        -- add either basePower or addPower
        if power == 0 then
            power = p.basePower
        else
            power = power + p.addPower
        end

        -- set effect
        player:addStatusEffectEx(p.effect, 0, power, 0, 0, 0, zoneId)
        player:messageBasic(p.effect - 168)
    end
end

xi.cactuarRegimes.checkRegime = function(player, mob, regimeId, index, regimeType)
    local zoneID       = mob:getZoneID()
    local zoneData     = xi.cactuarRegimes.zoneData[zoneID]
    local trainingData = zoneData.trainingData[regimeId]
    local mobLevel     = mob:getMainLvl()
    local playerLevel = player:getMainLvl()
    local avgMobLevel  = player:getCharVar('[cactuarRegimes]avgMobLevel')
    local rewardModifier = 1
    -- dead players, or players not on this training regime, get no credit
    -- also prevents error when this function is called onMobDeath from a mob not killed by a player
    if
        not player or
        player:getHP() == 0 or
        (player:getCharVar('[cactuarRegimes]zone') ~= zoneID or
        player:getCharVar('[cactuarRegimes]regimeId') ~= regimeId)
    then
        return
    end

    -- people in alliance get no fields credit unless FOV_REWARD_ALLIANCE is 1 in settings/main.lua
    if
        xi.settings.main.FOV_REWARD_ALLIANCE ~= 1 and
        regimeType == xi.regime.type.FIELDS and
        player:checkSoloPartyAlliance() == 2
    then
        return
    end

    -- people in alliance get no grounds credit unless GOV_REWARD_ALLIANCE is 1 in settings/main.lua
    if
        xi.settings.main.GOV_REWARD_ALLIANCE ~= 1 and
        regimeType == xi.regime.type.GROUNDS and
        player:checkSoloPartyAlliance() == 2
    then
        return
    end

    -- mobs that give no XP give no credit
    if not player:checkKillCredit(mob) then
        return
    end

    -- get number of this mob needed, and killed so far
    local needed = player:getCharVar('[cactuarRegimes]needed' .. index)
    local killed = player:getCharVar('[cactuarRegimes]killed' .. index)

    -- already finished with this mob
    if killed == needed then
        return
    end

    -- increment number killed
    killed = killed + 1
    player:messageBasic(xi.msg.basic.FOV_DEFEATED_TARGET, killed, needed)
    player:setCharVar('[cactuarRegimes]killed' .. index, killed)
    player:setCharVar('[cactuarRegimes]avgMobLevel', (avgMobLevel + mobLevel) / 2)

    -- this mob is not yet finished
    if needed > killed then
        return
    end

    if
        trainingData.obj1_count ~= nil and
        player:getCharVar('[cactuarRegimes]killed' .. 1) < trainingData.obj1_count
    then
        return
    end
    if
        trainingData.obj2_count ~= nil and
        player:getCharVar('[cactuarRegimes]killed' .. 2) < trainingData.obj2_count
    then
        return
    end
    if
        trainingData.obj3_count ~= nil and
        player:getCharVar('[cactuarRegimes]killed' .. 3) < trainingData.obj3_count
    then
        return
    end
    if
        trainingData.obj1_count ~= nil and
        player:getCharVar('[cactuarRegimes]killed' .. 4) < trainingData.obj4_count
    then
        return
    end

    -- get base reward
    player:messageBasic(xi.msg.basic.FOV_COMPLETED_REGIME)
    local reward = trainingData.expReward

    -- adjust reward down if regime is higher than server mob level cap
    -- example: if you have mobs capped at level 80, and the regime is level 100, you will only get 80% of the reward
    -- "Currently commented out as we are defining our own regimes/regime data" - Umeboshi
    --[[if
        xi.settings.main.NORMAL_MOB_MAX_LEVEL_RANGE_MAX > 0 and
        trainingData.max_level > xi.settings.main.NORMAL_MOB_MAX_LEVEL_RANGE_MAX
    then
        local avgCapLevel = (xi.settings.main.NORMAL_MOB_MAX_LEVEL_RANGE_MIN + xi.settings.main.NORMAL_MOB_MAX_LEVEL_RANGE_MAX) / 2
        local avgMobLevel = (trainingData.min_level + trainingData.max_level) / 2

        reward = math.floor(reward * avgCapLevel / avgMobLevel)
    end]]
    rewardModifier = avgMobLevel / playerLevel
    -- print(rewardModifier)
    reward = math.floor(reward * rewardModifier)

    -- prowess buffs from completing Grounds regimes
    --if regimeType == xi.regime.type.GROUNDS then
        addGovProwessBonusEffect(player)

        -- repeat clears bonus
        if player:hasStatusEffect(xi.effect.PROWESS) then
            -- increase reward based on number of clears. hard caps at 2x base reward.
            local govClears  = player:getStatusEffect(xi.effect.PROWESS):getPower()
            local baseReward = reward

            reward = reward * (100 + (govClears * 4)) / 100
            reward = utils.clamp(reward, 0, baseReward * 2)

            -- increment clears
            player:delStatusEffectSilent(xi.effect.PROWESS)
            player:addStatusEffect(xi.effect.PROWESS, govClears + 1, 0, 0, 0, zoneID)

        else
            -- keep track of number of clears
            player:addStatusEffect(xi.effect.PROWESS, 1, 0, 0, 0, zoneID)
        end
    --end

    -- award gil and tabs once per day, or at every page completion if REGIME_WAIT is 0 in settings.lua
    local vanadielEpoch = VanadielUniqueDay()

        --[[WINGSCUSTOM diminishing returns on page rewards for repeated completions on same day
    if player:getCharVar('[regime]lastReward') < vanadielEpoch then
        local completions = player:getCharVar('[regime]repeatedCompletions')
        if completions > 0 then
            reward = math.ceil(reward * (.85 ^ completions))
            player:printToPlayer('Field Manual : You are getting a reduced reward from completing multiple pages on the same day!', xi.msg.channel.SYSTEM_3)
            --player:printToPlayer(string.format('Field Manual : You are getting a reduced reward from completing %u pages on the same day!', completions), xi.msg.channel.SYSTEM_3)
        end
        player:setCharVar('[regime]repeatedCompletions', completions + 1)
    else
        player:setCharVar('[regime]repeatedCompletions', 0)
    end]]

    if
        xi.settings.main.REGIME_WAIT == 0 or
        player:getCharVar('[cactuarRegimes]lastReward') < vanadielEpoch
    then
        -- gil
        player:addGil(reward)
        player:messageBasic(xi.msg.basic.FOV_OBTAINS_GIL, reward)

        -- tabs
        local tabs = math.floor(reward / 10) * xi.settings.main.TABS_RATE
        tabs       = utils.clamp(tabs, 0, 50000 - player:getCurrency('valor_point')) -- Retail caps players at 50000 tabs

        player:addCurrency('valor_point', tabs)
        player:messageBasic(xi.msg.basic.FOV_OBTAINS_TABS, tabs, player:getCurrency('valor_point'))

        player:setCharVar('[cactuarRegimes]lastReward', vanadielEpoch)
    end

    -- Award EXP for page completion
    -- Player must be equal or greater than REGIME_REWARD_THRESHOLD levels below the minimum suggested level
    if player:getMainLvl() >= math.max(1, trainingData.min_level - xi.settings.main.REGIME_REWARD_THRESHOLD) then
        player:addExp(reward * xi.settings.main.BOOK_EXP_RATE)
    end

    -- repeating regimes
    if player:getCharVar('[cactuarRegimes]repeat') == 1 then
        for i = 1, 4 do
            player:setCharVar('[cactuarRegimes]killed' .. i, 0)
            player:setCharVar('[cactuarRegimes]avgMobLevel', 0)
        end

        player:messageBasic(xi.msg.basic.FOV_REGIME_BEGINS_ANEW)
    else
        xi.cactuarRegimes.clearRegimeVars(player)
    end
end