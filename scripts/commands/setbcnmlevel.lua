-----------------------------------
-- func: additem <itemId> <quantity> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4> <trial>
-- desc: Adds an item to the GMs inventory.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!setbcnmlevel <level (BCNM Original Level Cap - Level 75)>')
    player:printToPlayer('The player registering the battlefield can use this command to set the level scaling of the battlefield.')
    player:printToPlayer('Note: Battlefield level scaling can not go below the original era level cap.')
end

commandObj.onTrigger = function(player, arg1)

    local level = arg1

    -- validate item
    if level == nil then
        -- No level defined
        player:printToPlayer('Error: No level defined.', xi.msg.channel.SYSTEM_3)
        return
    elseif (level < 0) or (level > 75) then
        player:printToPlayer('Error: Level value out of bounds.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Level Range: BCNM Original Level Cap - Level 75', xi.msg.channel.SYSTEM_3)
        return
    end

    player:setLocalVar('Cactuar_BCNM_Level', level)
    player:printToPlayer(string.format('Battlefield level scaling set to %i', level), xi.msg.channel.SYSTEM_3)
end

return commandObj
