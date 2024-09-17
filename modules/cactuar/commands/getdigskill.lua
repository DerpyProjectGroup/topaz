-----------------------------------
-- func: getskill <skill name or ID> <target>
-- desc: returns target's level of specified skill
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getdigskill (player)')
end
commandObj.onTrigger = function(player, target)
    local targ = nil

    if target == nil then
        if player:getCursorTarget() == nil then
            targ = player
        else
            if player:getCursorTarget():isPC() then
                targ = player:getCursorTarget()
            else
                error(player, 'You must target a player or specify a name.')
                return
            end
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            player:printToPlayer(string.format('Player named %s not found!', target))
            return
        end
    end

    player:printToPlayer(string.format('%s\'s current Chocobo Dig Skill is Level: %s', targ:getName(), (targ:getCharSkillLevel(xi.skill.DIG) / 10)))
end

return commandObj
