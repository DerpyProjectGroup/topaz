-----------------------------------
-- Cacophonous Discord
-- Rhapsodies of Vana'diel Mission 2-34
-----------------------------------
-- !addmission 13 122
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.CACOPHONOUS_DISCORD)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.EDDIES_OF_DESPAIR_II },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ESCHA_RUAUN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 5
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
