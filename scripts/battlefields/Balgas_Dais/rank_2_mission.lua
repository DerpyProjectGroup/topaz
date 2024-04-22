-----------------------------------
-- Area: Balgas Dais
-- Name: Mission Rank 2
-- !pos 299 -123 345 146
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.BALGAS_DAIS,
    battlefieldId = xi.battlefield.id.RANK_2_MISSION,
    isMission     = true,
    maxPlayers    = 6,
    levelCap      = 25,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
})

function content:checkRequirements(player, npc, isRegistrant, trade)
    if trade then
        return false
    end

    local isCurrentMission   = player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_WINDURST2 or
        player:getCurrentMission(xi.mission.log_id.BASTOK) == xi.mission.id.bastok.THE_EMISSARY_WINDURST2
    local currentRequiremets = isCurrentMission and player:hasKeyItem(xi.ki.DARK_KEY)
    local nonRegistrantReqs  = player:hasCompletedMission(player:getNation(), 5) or currentRequiremets

    return (not isRegistrant and nonRegistrantReqs) or currentRequiremets
end

function content:onBattlefieldWin(player, battlefield)
    if
        player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_WINDURST2 or
        player:getCurrentMission(xi.mission.log_id.BASTOK) == xi.mission.id.bastok.THE_EMISSARY_WINDURST2
    then
        player:setLocalVar('battlefieldWin', battlefield:getID())
    end

    local _, clearTime, partySize = battlefield:getRecord()

    local nationStatus = player:getMissionStatus(player:getNation())
    local canSkipCS    = player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_WINDURST2) or
                player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST2) or
                (nationStatus > 8 and
                (
                    player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_WINDURST2 or
                    player:getCurrentMission(xi.mission.log_id.BASTOK) == xi.mission.id.bastok.THE_EMISSARY_WINDURST2
                ))

    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, self.index, canSkipCS)
end

content.groups =
{
    {
        mobIds =
        {
            { balgasID.mob.BLACK_DRAGON,     balgasID.mob.BLACK_DRAGON + 1 },
            { balgasID.mob.BLACK_DRAGON + 2, balgasID.mob.BLACK_DRAGON + 3 },
            { balgasID.mob.BLACK_DRAGON + 4, balgasID.mob.BLACK_DRAGON + 5 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()