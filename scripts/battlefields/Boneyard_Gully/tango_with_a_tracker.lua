-----------------------------------
-- Requiem Of A Sin
-- !pos -345 104 -260 144
-----------------------------------
local boneyardGullyID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.TANGO_WITH_A_TRACKER,
    maxPlayers       = 6,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 6,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    requiredKeyItems = 
    {
        xi.ki.LETTER_FROM_SHIKAREE_X,
    },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER,
})

function content:onBattlefieldWin(player, battlefield)
    local _, clearTime, partySize = battlefield:getRecord()

    player:setLocalVar('battlefieldWin', battlefield:getID())
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), player:getZoneID(), self.index, 0)
    player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER)
    player:addGil(10000)
    player:addTitle(xi.title.SIN_HUNTER_HUNTER)
end

content.groups =
{
    {
        mobIds =
        {
            {
                boneyardGullyID.mob.SHIKAREE_Z + 99,  -- Shikaree Z
                boneyardGullyID.mob.SHIKAREE_Z + 100, -- Shikaree Y
                boneyardGullyID.mob.SHIKAREE_Z + 101, -- Shikaree X
            },

            {
                boneyardGullyID.mob.SHIKAREE_Z + 105, -- Shikaree Z
                boneyardGullyID.mob.SHIKAREE_Z + 106, -- Shikaree Y
                boneyardGullyID.mob.SHIKAREE_Z + 107, -- Shikaree X
            },

            {
                boneyardGullyID.mob.SHIKAREE_Z + 111, -- Shikaree Z
                boneyardGullyID.mob.SHIKAREE_Z + 112, -- Shikaree Y
                boneyardGullyID.mob.SHIKAREE_Z + 113, -- Shikaree X
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    -- Shikaree X Rabbits
    {
        mobIds =
        {
            { boneyardGullyID.mob.SHIKAREE_Z + 103  },
            { boneyardGullyID.mob.SHIKAREE_Z + 109  },
            { boneyardGullyID.mob.SHIKAREE_Z + 115 },
        },
    },

    -- Shikaree Z Wyverns
    {
        mobIds =
        {
            { boneyardGullyID.mob.SHIKAREE_Z + 102  },
            { boneyardGullyID.mob.SHIKAREE_Z + 108  },
            { boneyardGullyID.mob.SHIKAREE_Z + 114 },
        },

        spawned = true,
    },
}

return content:register()
