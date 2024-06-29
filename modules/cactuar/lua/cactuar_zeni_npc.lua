-----------------------------------
-- Adds Zeni exchange NPC
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('cactuar_zeni_npc')

m:addOverride('xi.zones.Aht_Urhgan_Whitegate.Zone.onInitialize', function(zone)

    super(zone)
    
        local CurrencyNPC = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = 'Emul',

        look = 270,

        x = -125.104,
        y =    2.000,
        z =  21.5542,

        rotation = 88,

        widescan = 1,

        onTrigger = function(player, npc)

        player:printToPlayer('Emul: You can purchase Zeni with Merit Points.', xi.msg.channel.NS_SAY)

local menu  = {}
local page1 = {}
local page2 = {}

local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
        npc:facePlayer(player)
    end)
end

menu =
{
    title = 'Exchange (1)Merit Points for (200)Zeni',
    options = {},
}

-- Currency Catagory Menu
page1 =
{
    {   
        'I want to purchase Zeni',
        function(playerArg)
                menu.options = page2
                local currentMerits = playerArg:getMeritCount()
                local zeniAmount    = playerArg:getCurrency('zeni_point')
                playerArg:printToPlayer('Emul: I will trade you 200 Zeni for 1 Merit Point. Sound good?', xi.msg.channel.NS_SAY)
                playerArg:printToPlayer('You currently have '.. zeniAmount ..' Zeni.', xi.msg.channel.SYSTEM_3)
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
            local cost          = 1
            local zeniAmount    = playerArg:getCurrency('zeni_point')
            if currentMerits < 1 then
                playerArg:printToPlayer('Emul: I am afraid you currently do not have enough merits for Zeni.', xi.msg.channel.NS_SAY)
            else
                playerArg:setMerits(currentMerits - cost)
                playerArg:addCurrency('zeni_point', 200)
                playerArg:printToPlayer('You obtain 200 Zeni.', xi.msg.channel.SYSTEM_3)
                playerArg:printToPlayer('You currently have '.. zeniAmount ..' Zeni.', xi.msg.channel.SYSTEM_3)
                playerArg:printToPlayer('You now have '.. currentMerits ..' Merits.', xi.msg.channel.SYSTEM_3)
                playerArg:printToPlayer('Emul: Here\'s your Zeni!', xi.msg.channel.NS_SAY)
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
