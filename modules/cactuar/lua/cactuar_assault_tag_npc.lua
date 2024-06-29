-----------------------------------
-- Adds Assault ID Tag Purchase NPC
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('cactuar_assault_tag_npc')

m:addOverride('xi.zones.Aht_Urhgan_Whitegate.Zone.onInitialize', function(zone)

    super(zone)
    
        local CurrencyNPC = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = 'Singing Owl',

        -- look = 2364,
        look = '0x0100080840109F209F309F409F50006000700000',

        x = 115.473,
        y =  -0.315,
        z = -42.172,

        rotation = 162,

        widescan = 1,

        onTrigger = function(player, npc)

        player:printToPlayer('Singing Owl: Greetings Mercenary, you can purchase tags here with Merit Points.', xi.msg.channel.NS_SAY)
        npc:sendNpcEmote(player, xi.emote.SALUTE, xi.emoteMode.MOTION)

local menu  = {}
local page1 = {}
local page2 = {}

local delaySendMenu = function(player)
    player:timer(1000, function(playerArg)
        playerArg:customMenu(menu)
        npc:facePlayer(player)
    end)
end

menu =
{
    title = 'Buy Assault Tags',
    options = {},
}

page1 =
{
    {   
        'I want to purchase tags',
        function(playerArg)
                menu.options = page2
                local currentMerits = playerArg:getMeritCount()
                playerArg:printToPlayer('Singing Owl: Each tag will cost 5 Merits, do you wish to confirm your purchase?', xi.msg.channel.NS_SAY)
                playerArg:printToPlayer('You currently have '.. currentMerits ..' Merits.', xi.msg.channel.SYSTEM_3)
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Exit',
        function(playerArg)
        end,
    },
}

page2 =
{
    {
        'Yes',
        function(playerArg)
            menu.options = page2
            local currentMerits = playerArg:getMeritCount()
            local cost          = 5
            local tagStock      = playerArg:getCurrency('id_tags')
            if currentMerits < 5 then
                playerArg:printToPlayer('Singing Owl: I am afraid you currently do not have enough merits to purchase.', xi.msg.channel.NS_SAY)
                npc:sendNpcEmote(player, xi.emote.AMAZED, xi.emoteMode.MOTION)
            elseif tagStock >= 7 then
                playerArg:printToPlayer('Singing Owl: You seem to have '.. tagStock ..' Tags stored already. Make sure you use some first before buying more. ', xi.msg.channel.NS_SAY)
            else
                playerArg:setMerits(currentMerits - cost)
                playerArg:addCurrency('id_tags', 1)
                playerArg:printToPlayer('You purchased 1 Imperial Army I.D Tag.', xi.msg.channel.SYSTEM_3)
                playerArg:printToPlayer('You now have '.. currentMerits ..' Merits.', xi.msg.channel.SYSTEM_3)
                npc:sendNpcEmote(player, xi.emote.POINT, xi.emoteMode.MOTION)
                playerArg:printToPlayer('Singing Owl: I have confirmed your purchase, here is your tag. The Empire appreciates your support.', xi.msg.channel.NS_SAY)
            end
            delaySendMenu(playerArg)
        end,
    },
    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

menu.options = page1
delaySendMenu(player)
        end,
    })

end)

return m
