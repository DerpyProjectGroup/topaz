-----------------------------------
-- Add some test NPCs to GM_HOME (zone 210)
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
require('modules/module_utils')
require('scripts/zones/Uleguerand_Range/Zone')
-----------------------------------
local m = Module:new('uleguerand_range_waterfall')

m.waterfall_qm = nil  -- Define it initially as nil

m:addOverride('xi.zones.Uleguerand_Range.Zone.onInitialize', function(zone)

    super(zone)
    
        m.waterfall_qm = zone:insertDynamicEntity({
        
        objtype = xi.objType.NPC,
    
        name = '???',

        look = 2424,

        x =  2.9848,
        y = -177.0255,
        z =  66.9628,

        rotation = 233,

        widescan = 0,

        onTrade = function(player, npc, trade)
            local waterfall = GetNPCByID(ID.npc.WATERFALL)
            if npcUtil.tradeHas(trade, { { 4104, 6 } }) then -- Fire Cluster x 6 Trade
                player:confirmTrade()
                player:independentAnimation(player, 38, 1)
                npc:timer(300000, function(npcArg) -- ??? Reappears after 5 min
                    npcArg:setStatus(xi.status.NORMAL)
                end)
                npc:timer(2000, function(npcArg)
                    npc:independentAnimation(npc, 174, 0)
                end)
                npc:timer(5500, function(npcArg)
                    waterfall:openDoor(300) -- Open for 5min
                    npc:setStatus(xi.status.DISAPPEAR) -- ??? Disappears for 5min
                end)
            end
        end,


        onTrigger = function(player, npc)
            player:printToPlayer('The focused heat of 6 Fire Clusters may be able to melt the ice.', xi.msg.channel.NS_SAY)
        end,

    })
end)

m:addOverride('xi.zones.Uleguerand_Range.Zone.onZoneWeatherChange', function(weather)

    super(weather)

    local waterfall = GetNPCByID(ID.npc.WATERFALL)
    if weather == xi.weather.SNOW or weather == xi.weather.BLIZZARDS then
        if waterfall:getAnimation() ~= xi.anim.CLOSE_DOOR then
            waterfall:setAnimation(xi.anim.CLOSE_DOOR)
            m.waterfall_qm:setStatus(xi.status.NORMAL)
        end
    else
        if waterfall:getAnimation() ~= xi.anim.OPEN_DOOR then
            waterfall:setAnimation(xi.anim.OPEN_DOOR)
            m.waterfall_qm:setStatus(xi.status.DISAPPEAR)
        end
    end
end)

return m
