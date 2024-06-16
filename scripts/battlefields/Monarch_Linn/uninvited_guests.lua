-----------------------------------
-- Area: Monarch Linn
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.UNINVITED_GUESTS,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 6,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.ki.MONARCH_LINN_PATROL_PERMIT, message = ID.text.KI_TORN },
})

content.groups =
{
    {
        mobIds =
        {
            {
                monarchLinnID.mob.MAMMET_800_OFFSET,
            },

            {
                monarchLinnID.mob.MAMMET_800_OFFSET + 19,
            },

            {
                monarchLinnID.mob.MAMMET_800_OFFSET + 20,
            },
        },
    },

    {
        mobIds =
        {
            {
                monarchLinnID.mob.MAMMET_800_OFFSET + 1,
                monarchLinnID.mob.MAMMET_800_OFFSET + 2,
                monarchLinnID.mob.MAMMET_800_OFFSET + 3,
                monarchLinnID.mob.MAMMET_800_OFFSET + 4,
                monarchLinnID.mob.MAMMET_800_OFFSET + 5,
                monarchLinnID.mob.MAMMET_800_OFFSET + 6,
                monarchLinnID.mob.MAMMET_800_OFFSET + 7,
                monarchLinnID.mob.MAMMET_800_OFFSET + 8,
            },

            {
                monarchLinnID.mob.MAMMET_800_OFFSET + 11,
                monarchLinnID.mob.MAMMET_800_OFFSET + 12,
                monarchLinnID.mob.MAMMET_800_OFFSET + 13,
                monarchLinnID.mob.MAMMET_800_OFFSET + 14,
                monarchLinnID.mob.MAMMET_800_OFFSET + 15,
                monarchLinnID.mob.MAMMET_800_OFFSET + 16,
                monarchLinnID.mob.MAMMET_800_OFFSET + 17,
                monarchLinnID.mob.MAMMET_800_OFFSET + 18,
            },

            {
                monarchLinnID.mob.MAMMET_800_OFFSET + 21,
                monarchLinnID.mob.MAMMET_800_OFFSET + 22,
                monarchLinnID.mob.MAMMET_800_OFFSET + 23,
                monarchLinnID.mob.MAMMET_800_OFFSET + 24,
                monarchLinnID.mob.MAMMET_800_OFFSET + 25,
                monarchLinnID.mob.MAMMET_800_OFFSET + 26,
                monarchLinnID.mob.MAMMET_800_OFFSET + 27,
                monarchLinnID.mob.MAMMET_800_OFFSET + 28,
            },
        },
        spawned  = false,
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

function content:onEventFinishWin(player, csid, option, npc)
    -- Victory
    player:setCharVar('UninvitedGuestsStatus', 2) -- update to victory state
end

function content:onEventFinishExit(player, csid, option, npc)
    if option == 4 and player:getBattlefield() then
        player:leaveBattlefield(1)
        -- However the player got out of the BCNM - they didnt win
        player:setCharVar('UninvitedGuestsStatus', 3) -- update to failure state
    end
end

function content:onEventFinishLeave(player, csid, option, npc)
    player:leaveBattlefield(1)
    -- However the player got out of the BCNM - they didnt win
    player:setCharVar('UninvitedGuestsStatus', 3) -- update to failure state
end

return content:register()
