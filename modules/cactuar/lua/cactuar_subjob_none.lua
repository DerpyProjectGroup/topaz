-----------------------------------
-- Adds an NPC in the moghouse that lets players change their subjob to NONE.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('cactuar_subjob_none')

m:addOverride('xi.zones.RuLude_Gardens.Zone.onInitialize', function(zone)

    super(zone)
        local mogmog = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
    
        name = 'Mogmog',

        look = 2364,

        x = 11.160,
        y =  3.100,
        z = 120.113,

        rotation = 114,

        widescan = 1,

        onTrade = function(player, npc, trade)

        end,


        onTrigger = function(player, npc)

local menu  = {}
local page1 = {}
local page2 = {}

local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

menu =
{
    title = 'Disable Subjob',
    options = {},
}

page1 =
{
    {   
        'Disable my Subjob? Why would I want that?',
        function(playerArg)
                playerArg:printToPlayer('MogMog: You can disable your subjob but in exchange, you will get increased base attributes. Worry not kupo, you can always change it back in your mog house.', xi.msg.channel.NS_SAY)
                npc:lookAt(player:getPos())
                npc:timer(10000, function(npcArg)
                    npcArg:setRotation(114)
                end)
                npc:timer(1500, function(npcArg)
                    playerArg:printToPlayer('MogMog: Aside from speaking to me, you may now also use the "!sjlock" command to channel your inner strength with one job.', xi.msg.channel.NS_SAY)
                end)
                if playerArg:getCharVar('MogMog_Spoken_SubJobLock') == 0 then
                    playerArg:setCharVar('MogMog_Spoken_SubJobLock', 1) -- Player has spoken to Mogmog, can now use !sjlock command.
                end
                menu.options = page1
                delaySendMenu(playerArg) 
        end,
    },

    {
        'Disable Subjob',
        function(playerArg)
            playerArg:printToPlayer('Your subjob has been disabled. You can revert it later by speaking to your moogle to set your subjob.', xi.msg.channel.SYSTEM_3) 
            playerArg:changesJob(0)
            if playerArg:getCharVar('MogMog_Spoken_SubJobLock') == 0 then
                playerArg:setCharVar('MogMog_Spoken_SubJobLock', 1) -- Player has spoken to Mogmog, can now use !sjlock command.
            end
        end,
    },
}

menu.options = page1
delaySendMenu(player)
        end,
    })

end)

return m
