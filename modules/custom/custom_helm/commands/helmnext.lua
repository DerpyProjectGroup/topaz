-----------------------------------
-- func: helmnext
-- desc: Move to the next HELM point in the list
-----------------------------------
require('scripts/globals/helm')
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local getHelmType = function(zoneID)
    for k, v in pairs(xi.helmType) do
        if xi.helm.helmInfo[v].zone[zoneID] then
            return v
        end
    end

    return 0
end

commandObj.onTrigger = function(player, dir)
    local var      = '[HELM]AT_POINT'
    local zoneID   = player:getZoneID()
    local point    = player:getLocalVar(var)
    local helmType = getHelmType(zoneID)

    if helmType == 0 then
        return
    end

    local points = xi.helm.helmInfo[helmType].zone[zoneID].points

    if dir ~= 0 then
        if point < 2 then
            point = #points
        else
            point = point - 1
        end
    else
        if point >= #points then
            point = 1
        else
            point = point + 1
        end
    end

    local nextPoint = points[point]

    player:printToPlayer(string.format(
        'Moving to point %d/%d @ %.3f, %.3f, %.3f',
        point,
        #points,
        nextPoint[1],
        nextPoint[2],
        nextPoint[3]
    ), xi.msg.channel.SYSTEM_3)

    player:setPos(unpack(nextPoint))
    player:setLocalVar(var, point)
end

return commandObj