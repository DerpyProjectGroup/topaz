-----------------------------------
-- Adds relic exchange NPC
-- !pos -27.1487 2.0029, 57.0718 243
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('cactuar_relic_exchange')

local relics = {
    { name = 'Spharai'      , id = xi.item.SPHARAI       },
    { name = 'Mandau'       , id = xi.item.MANDAU        },
    { name = 'Excalibur'    , id = xi.item.EXCALIBUR     },
    { name = 'Ragnarok'     , id = xi.item.RAGNAROK      },
    { name = 'Guttler'      , id = xi.item.GUTTLER       },
    { name = 'Bravura'      , id = xi.item.BRAVURA       },
    { name = 'Apocalypse'   , id = xi.item.APOCALYPSE    },
    { name = 'Gungnir'      , id = xi.item.GUNGNIR       },
    { name = 'Kikoku'       , id = xi.item.KIKOKU        },
    { name = 'Amanomurakumo', id = xi.item.AMANOMURAKUMO },
    { name = 'Mjollnir'     , id = xi.item.MJOLLNIR      },
    { name = 'Claustrum'    , id = xi.item.CLAUSTRUM     },
    { name = 'Yoichinoyumi' , id = xi.item.YOICHINOYUMI  },
    { name = 'Annihilator'  , id = xi.item.ANNIHILATOR   },
    { name = 'Gjallarhorn'  , id = xi.item.GJALLARHORN   },
    { name = 'Aegis'        , id = xi.item.AEGIS         },
}

m:addOverride('xi.zones.RuLude_Gardens.Zone.onInitialize', function(zone)

    super(zone)

    local Eldrin  = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,

        name = 'Eldrin',
        look = '0x01000E0300101920193019401950196000700080',

        x = -27.1487,
        y = 2.0029,
        z = 57.0718,

        rotation = 154,

        widescan = 1,

        onTrade = function(player, npc, trade)
            local zoneID = zones[player:getZoneID()]
    
            for _, r in ipairs(relics) do
                if
                    npcUtil.tradeHas(trade, {r.id, {xi.item.MONTIONT_SILVERPIECE, 10}, {xi.item.ONE_HUNDRED_BYNE_BILL, 10}, {xi.item.LUNGO_NANGO_JADESHELL, 10}}) or
                    npcUtil.tradeHas(trade, xi.item.RELIC_VOUCHER)
                then
                    if player:getFreeSlotsCount() == 0 then -- No free slots available
                        player:messageSpecial(zoneID.text.ITEM_CANNOT_BE_OBTAINED, player:getLocalVar('[RelicExchange]'))
                        return
                    elseif player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) ~= xi.questStatus.QUEST_COMPLETED then
                        player:printToPlayer('Eldrin: I\'m sorry, I can\'t accept this. You\'ve yet to prove yourself worthy of such an illustrious weapon.', xi.msg.channel.NS_SAY)
                        player:printToPlayer('Eldrin: Once all of your limits have been broken, return to me and I\'ll gladly present you with this weapon.', xi.msg.channel.NS_SAY)
                        return
                    elseif player:getLocalVar('[RelicExchange]') == 0 or nil then -- No selection made yet.
                        if
                            npcUtil.tradeHas(trade, {r.id, {xi.item.MONTIONT_SILVERPIECE, 10}, {xi.item.ONE_HUNDRED_BYNE_BILL, 10}, {xi.item.LUNGO_NANGO_JADESHELL, 10}})
                        then
                            player:printToPlayer('Eldrin: I see you have the required currency and wish to exchange a relic. Please let met know which Relic you would like.', xi.msg.channel.NS_SAY)
                        else
                            player:printToPlayer('Eldrin: I see you have a Relic Voucher to obtain a new relic. Please let met know which Relic you would like.', xi.msg.channel.NS_SAY)
                        end
                        return
                    end
                    player:addItem(player:getLocalVar('[RelicExchange]'))
                    player:messageSpecial(zoneID.text.ITEM_OBTAINED, player:getLocalVar('[RelicExchange]'))
                    player:confirmTrade()
                    print(string.format('[AUDIT] %s exchanged their relic weapon for %s', player:getName(), r.name))
                    break
                end
            end
        end,
        
        onTrigger = function(player, npc)

            local menu =  {}
            local page1 = {}
            local page2 = {}
            local page3 = {}
            local page4 = {}

            local delaySendMenu = function(player)
                player:timer(50, function(playerArg)
                    playerArg:customMenu(menu)
                end)
            end

            menu = {
                title = 'Relic Exchange',
                options = {}
            }

            -- Page 1
            table.insert(page1, {
                'Learn about exchange.',
                function(playerArg)
                    playerArg:printToPlayer('Eldrin : Here, we can exchange your old relic for a shiny new one.', xi.msg.channel.NS_SAY)
                    playerArg:printToPlayer('Eldrin : Nothing is free, of course. We require a fee of 10 Montiont Silverpieces, 10 One Hundred Byne Bills, and 10 Lungo Nango Jadeshells.', xi.msg.channel.NS_SAY)
                    playerArg:printToPlayer('Eldrin : We have been instructed to provide a free relic to anyone who presents me with a Relic Exchange Certificate.', xi.msg.channel.NS_SAY)
                end,
            })

            table.insert(page1, {
                'Exchange Relic',
                function(playerArg)
                    menu.options = page2
                    delaySendMenu(playerArg)
                end,
            })

            -- Page 2
            table.insert(page2, {
                'Previous Page',
                function(playerArg)
                    menu.options = page1
                    delaySendMenu(playerArg)
                end})

            for i = 1, 6 do
                local v = relics[i]
                table.insert(page2, {v.name, function(playerArg)
                    player:setLocalVar('[RelicExchange]', v.id)
                    playerArg:printToPlayer('Eldrin : ' .. v.name .. ', a fine choice. Bring me a relic of your choosing along with my fee of', xi.msg.channel.NS_SAY)
                    playerArg:printToPlayer('Eldrin : 10 Montiont Silverpieces, 10 One Hundred Byne Bills, and 10 Lungo Nango Jadeshells, and I shall exchange it.', xi.msg.channel.NS_SAY)
                    playerArg:printToPlayer('Eldrin : Or, if you have one, you can present me with a Relic Exchange Certificate.', xi.msg.channel.NS_SAY)
                end})
            end

            table.insert(page2, {
                'Next Page',
                function(playerArg)
                    menu.options = page3
                    delaySendMenu(playerArg)
                end})

            -- Page 3
            table.insert(page3, {
                'Previous Page',
                function(playerArg)
                    menu.options = page2
                    delaySendMenu(playerArg)
                end})

            for i = 7, 12 do
                local v = relics[i]
                table.insert(page3, {v.name, function(playerArg)
                    player:setLocalVar('[RelicExchange]', v.id)
                    playerArg:printToPlayer('Eldrin : ' .. v.name .. ', a fine choice. Bring me a relic of your choosing along with my fee of', xi.msg.channel.NS_SAY)
                    playerArg:printToPlayer('Eldrin : 10 Montiont Silverpieces, 10 One Hundred Byne Bills, and 10 Lungo Nango Jadeshells, and I shall exchange it.', xi.msg.channel.NS_SAY)
                    playerArg:printToPlayer('Eldrin : Or, if you have one, you can present me with a Relic Exchange Certificate.', xi.msg.channel.NS_SAY)
                end})
            end

            table.insert(page3, {
                'Next Page',
                function(playerArg)
                    menu.options = page4
                    delaySendMenu(playerArg)
                end})

            -- Page 4
            table.insert(page4, {
                'Previous Page',
                function(playerArg)
                    menu.options = page3
                    delaySendMenu(playerArg)
                end})

            for i = 13, 16 do
                local v = relics[i]
                table.insert(page4, {v.name, function(playerArg)
                    player:setLocalVar('[RelicExchange]', v.id)
                    playerArg:printToPlayer('Eldrin : ' .. v.name .. ', a fine choice. Bring me a relic of your choosing along with my fee of', xi.msg.channel.NS_SAY)
                    playerArg:printToPlayer('Eldrin : 10 Montiont Silverpieces, 10 One Hundred Byne Bills, and 10 Lungo Nango Jadeshells, and I shall exchange it.', xi.msg.channel.NS_SAY)
                    playerArg:printToPlayer('Eldrin : Or, if you have one, you can present me with a Relic Exchange Certificate.', xi.msg.channel.NS_SAY)
                end})
            end

            npc:facePlayer(player)
            menu.options = page1
            delaySendMenu(player)
        end
    })

end)

return m
