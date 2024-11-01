-----------------------------------
-- func: getskill <skill name or ID> <target>
-- desc: returns target's level of specified skill
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getskill <skill name or ID> (entity)')
end

commandObj.onTrigger = function(player, skillName, target)
    if skillName == nil then
        error(player, 'You must specify a skill to check!')
        return
    end

    local skillID = tonumber(skillName) or xi.skill[string.upper(skillName)]
    local targ = nil

    if target == nil then
        if player:getCursorTarget() == nil then
            targ = player
        else
            if player:getCursorTarget() then
                targ = player:getCursorTarget()
            else
                error(player, 'You must target a player or specify a name.')
                return
            end
        end
    else
        if targ == nil then
            player:printToPlayer('Curser target not found!')
            return
        end
    end

    -- Trying to break this wide line in any other more reasonable way results in lua throwing errors.. Parsing bug.
    player:printToPlayer(string.format('%s\'s current skillID \'%s\' Skill: %s (real value: %s)',
    targ:getName(), skillName, (targ:getSkillLevel(skillID) / 10) .. '.x', targ:getSkillLevel(skillID)))
end

return commandObj
