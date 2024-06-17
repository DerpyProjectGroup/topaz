-----------------------------------
-- func: helmlist
-- desc: Parse a HELM drop list to test and hand out each item
-----------------------------------
require('scripts/globals/helm')
require('scripts/globals/npc_util')
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
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
    local zoneID   = player:getZoneID()
    local helmType = getHelmType(zoneID)

    if helmType == 0 then
        return
    end

    local drops = xi.helm.helmInfo[helmType].zone[zoneID].drops
    local items = {}

    player:printToPlayer(string.format(
        'Parse HELM drop list for %s',
        player:getZoneName()),
        xi.msg.channel.SYSTEM_3
    )

    for _, v in pairs(drops) do
        print(v)
        player:printToPlayer(string.format(
            '(%d) %s: %.2f%%',
            v[2], v[3], v[1] / 10),
            xi.msg.channel.NS_SAY
        )
        table.insert(items, v[2])
    end

    npcUtil.giveItem(player, items)
end

return commandObj