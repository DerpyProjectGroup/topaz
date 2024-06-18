-----------------------------------
-- Custom HELM
-----------------------------------
require('modules/module_utils')
require('scripts/globals/helm')


local customUtil = require('modules/custom/lua/custom_util')
-----------------------------------
local m = Module:new('custom_helm')

m.rate = customUtil.rate

local settings =
{
    dialog =
    {
        check = '%s is possible here if you have a %s.',
        full  = 'You cannot carry any more items. Your inventory is full.',
    },

    vars =
    {
        LAST_TRADE = '[HELM]Last_Trade',
        LOCAL_USES = 'uses',
    },

    [xi.helmType.HARVESTING] =
    {
        name    = 'Harvesting Point',
        type    = 'Harvesting',
        tool    = 'sickle',
        look    = 2422,
        unable  = 'You are unable to harvest anything.',
        success = 'You succesfully harvest %s!',
        process = 'You harvest %s, but your %s breaks.', -- Intentional
        breaks  = 'Your %s breaks!',
    },

    [xi.helmType.EXCAVATION] =
    {
        name    = 'Excavation Point',
        type    = 'Excavation',
        tool    = 'pickaxe',
        look    = 2424,
        unable  = 'You are unable to mine anything.',
        success = 'You successfully dig up %s!',
        process = 'You dig up %s, but your %s breaks in the process.',
        breaks  = 'Your %s breaks!',
    },

    [xi.helmType.LOGGING] =
    {
        name    = 'Logging Point',
        type    = 'Logging',
        tool    = 'hatchet',
        look    = 2423,
        unable  = 'You are unable to log anything.',
        success = 'You successfully cut off %s!',
        process = 'You cut off %s, but your %s breaks in the process.',
        breaks  = 'Your %s breaks!',
    },

    [xi.helmType.MINING] =
    {
        name    = 'Mining Point',
        type    = 'Mining',
        tool    = 'pickaxe',
        look    = 2424,
        unable  = 'You are unable to mine anything.',
        success = 'You successfully dig up %s!',
        process = 'You dig up %s, but your %s breaks in the process.',
        breaks  = 'Your %s breaks!',
    },
}

local rocks =
{
    [xi.element.FIRE   ] = { xi.item.RED_ROCK,         'a red rock',         },
    [xi.element.ICE    ] = { xi.item.TRANSLUCENT_ROCK, 'a translucent rock', },
    [xi.element.WIND   ] = { xi.item.GREEN_ROCK,       'a green rock',       },
    [xi.element.EARTH  ] = { xi.item.YELLOW_ROCK,      'a yellow rock',      },
    [xi.element.THUNDER] = { xi.item.PURPLE_ROCK,      'a purple rock',      },
    [xi.element.WATER  ] = { xi.item.BLUE_ROCK,        'a blue rock',        },
    [xi.element.LIGHT  ] = { xi.item.WHITE_ROCK,       'a white rock',       },
    [xi.element.DARK   ] = { xi.item.BLACK_ROCK,       'a black rock',       },
}

local clusters =
{
    [xi.element.FIRE   ] = { xi.item.FIRE_CLUSTER,      'a fire cluster',      },
    [xi.element.ICE    ] = { xi.item.ICE_CLUSTER,       'an ice cluster',      },
    [xi.element.WIND   ] = { xi.item.WIND_CLUSTER,      'a wind cluster',      },
    [xi.element.EARTH  ] = { xi.item.EARTH_CLUSTER,     'an earth cluster',    },
    [xi.element.THUNDER] = { xi.item.LIGHTNING_CLUSTER, 'a lightning cluster', },
    [xi.element.WATER  ] = { xi.item.WATER_CLUSTER,     'a water cluster',     },
    [xi.element.LIGHT  ] = { xi.item.LIGHT_CLUSTER,     'a light cluster',     },
    [xi.element.DARK   ] = { xi.item.DARK_CLUSTER,      'a dark cluster',      },
}

m.pickItem = function(player, info)
    local zoneId = player:getZoneID()
    local drops = info.zone[zoneId].drops

    -- found nothing
    if math.random(100) > info.settingRate then
        return { 0, 0, '' }
    end

    local result = customUtil.pickItem(player, drops)

    -- if we picked a colored rock, change it to the day's element
    if result[1] == xi.item.RED_ROCK then
        result = rocks[VanadielDayElement()]
    end

    -- if we picked a cluster, change it to the day's element
    if result[1] == xi.item.FIRE_CLUSTER then
        result = clusters[VanadielDayElement()]
    end

    return result
end


m.onTrigger = function(player, npc, helmType)
    player:printToPlayer(string.format(
        settings.dialog.check,
        settings[helmType].type,
        settings[helmType].tool
    ), xi.msg.channel.NS_SAY)
end

m.onTrade = function(player, npc, trade, helmType)
    local info   = xi.helm.helmInfo[helmType]
    local zoneId = player:getZoneID()
    local lastTrade = player:getLocalVar(settings.vars.LAST_TRADE)

    -- HELM should remove invisible
    player:delStatusEffect(xi.effect.INVISIBLE)

    if trade:hasItemQty(info.tool, 1) and trade:getItemCount() == 1 then
        local item  = m.pickItem(player, xi.helm.helmInfo[helmType])
        local broke = xi.helm.doesToolBreak(player, helmType)
        local full  = (player:getFreeSlotsCount() == 0) and 1 or 0

        if os.time() > lastTrade + 3 then
            player:sendEmote(npc, xi.helm.helmInfo[helmType].animation, xi.emoteMode.MOTION, true)
            player:selfEmote(npc, xi.helm.helmInfo[helmType].animation, xi.emoteMode.MOTION)

            if full == 1 then
                player:printToPlayer(settings.dialog.full, xi.msg.channel.NS_SAY)
                return
            end

            -- Allow 3 seconds for animation
            player:timer(3000, function(playerArg)
                if broke == 1 then
                    -- tool broke but found item
                    if item[2] ~= 0 then
                        player:printToPlayer(string.format(
                            settings[helmType].process,
                            item[3],
                            settings[helmType].tool
                        ), xi.msg.channel.NS_SAY)

                    -- tool broke and no item
                    else
                        player:printToPlayer(string.format(
                            settings[helmType].breaks,
                            settings[helmType].tool
                        ), xi.msg.channel.NS_SAY)
                    end

                -- found item
                elseif item[2] ~= 0 then
                    player:printToPlayer(string.format(
                        settings[helmType].success,
                        item[3]
                    ), xi.msg.channel.NS_SAY)

                -- found nothing
                else
                    player:printToPlayer(settings[helmType].unable, xi.msg.channel.NS_SAY)
                end

                -- success! reward item and decrement number of remaining uses on the point
                if item[2] ~= 0 and full == 0 then
                    player:addItem(item[2])

                    local uses = (npc:getLocalVar(settings.vars.LOCAL_USES) - 1) % 4
                    npc:setLocalVar(settings.vars.LOCAL_USES, uses)

                    if uses == 0 then
                        xi.helm.movePoint(npc, zoneId, helmType)
                    end

                    player:triggerRoeEvent(xi.roeTrigger.HELM_SUCCESS, { ['skillType'] = helmType })
                end
            end)

            player:setLocalVar(settings.vars.LAST_TRADE, os.time())
        else
            player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)
        end
    else
        m.helmOnTrigger(player, npc, helmType)
    end
end

m:addOverride('xi.helm.initZone', function(zone, helmType)
    local zoneId = zone:getID()

    if not (xi.helm.helmInfo[helmType] and
        xi.helm.helmInfo[helmType].zone[zoneId] and
        xi.helm.helmInfo[helmType].zone[zoneId].dynamic
    ) then
        super(zone, helmType)
        return
    end

    local total = #xi.helm.helmInfo[helmType].zone[zoneId].points
    local spawn = math.floor(total / 3) + 1

    for i = 1, spawn do
        local dynamicPoint = zone:insertDynamicEntity({
            name      = settings[helmType].name,
            objtype   = xi.objType.NPC,
            look      = settings[helmType].look,
            x         = xi.helm.helmInfo[helmType].zone[zoneId].points[i][1],
            y         = xi.helm.helmInfo[helmType].zone[zoneId].points[i][2],
            z         = xi.helm.helmInfo[helmType].zone[zoneId].points[i][3],
            rotation  = 0,
            widescan  = 0,

            onTrigger = function(player, npc)
                m.onTrigger(player, npc, helmType)
            end,

            onTrade   = function(player, npc, trade)
                m.onTrade(player, npc, trade, helmType)
            end,
        })

        xi.helm.movePoint(dynamicPoint, zoneId, helmType)
    end
end)

return m
