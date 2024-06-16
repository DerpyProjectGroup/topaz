-----------------------------------
-- Area: Riverne Site #B01
-- Name: Wyrmking Descends
-- !pos 299 -123 345 146
-----------------------------------
local riverneID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.RIVERNE_SITE_B01,
    battlefieldId = xi.battlefield.id.WYRMKING_DESCENDS,
    maxPlayers    = 18,
    timeLimit     = utils.minutes(60),
    index         = 1,
    area          = 1,
    entryNpc      = 'Unstable_Displacement',
    exitNpc       = 'SD_BCNM_Exit',
    requiredItems = { xi.item.MONARCHS_ORB },
})

content.groups =
{
    {
        mobIds =
        {
            riverneID.mob.BAHAMUT_V2,
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            riverneID.mob.BAHAMUT_V2 + 1,
            riverneID.mob.BAHAMUT_V2 + 2,
            riverneID.mob.BAHAMUT_V2 + 3,
            riverneID.mob.BAHAMUT_V2 + 4,
            riverneID.mob.BAHAMUT_V2 + 5,
            riverneID.mob.BAHAMUT_V2 + 6,
            riverneID.mob.BAHAMUT_V2 + 7,
            riverneID.mob.BAHAMUT_V2 + 8,
            riverneID.mob.BAHAMUT_V2 + 9,
            riverneID.mob.BAHAMUT_V2 + 10,
            riverneID.mob.BAHAMUT_V2 + 11,
            riverneID.mob.BAHAMUT_V2 + 12,
            riverneID.mob.BAHAMUT_V2 + 13,
            riverneID.mob.BAHAMUT_V2 + 14,
            riverneID.mob.BAHAMUT_V2 + 15,
            riverneID.mob.BAHAMUT_V2 + 16,
        },
        spawned  = false,
    },
}

return content:register()
