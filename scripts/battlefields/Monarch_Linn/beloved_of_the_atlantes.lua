-----------------------------------
-- Area: Monarch Linn
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.BELOVED_OF_THE_ATLANTES,
    maxPlayers       = 18,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 5,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.ki.MONARCH_BEARD, message = ID.text.KI_TORN },
    grantXP          = 2500,
    armouryCrates    =
    {
        monarchLinnID.mob.WATCH_HIPPOGRYPH + 2,
        monarchLinnID.mob.WATCH_HIPPOGRYPH + 5,
        monarchLinnID.mob.WATCH_HIPPOGRYPH + 8,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                monarchLinnID.mob.WATCH_HIPPOGRYPH,
            },

            {
                monarchLinnID.mob.WATCH_HIPPOGRYPH + 3,
            },

            {
                monarchLinnID.mob.WATCH_HIPPOGRYPH + 6,
            },
        },
    },

    {
        mobIds =
        {
            {
                monarchLinnID.mob.WATCH_HIPPOGRYPH + 1,
            },

            {
                monarchLinnID.mob.WATCH_HIPPOGRYPH + 4,
            },

            {
                monarchLinnID.mob.WATCH_HIPPOGRYPH + 7,
            },
        },
        spawned  = false,
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { item = xi.item.NONE, weight = 600 },
        { item = 17133,        weight = 100 }, -- Chanter's Staff
        { item = 16965,        weight = 100 }, -- Koryukagemitsu
        { item = 18411,        weight = 100 }, -- Buboso
        { item = 17468,        weight = 100 }, -- Raise Rod
    },

    {
        { item = xi.item.NONE,         weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.CLOUD_EVOKER, weight = xi.loot.weight.LOW            },
    },

    {
        quantity = 2,
        { item = xi.item.NONE, weight = 600 },
        { item = 14682,        weight = 100 }, -- Kshama Ring No. 2
        { item = 14684,        weight = 100 }, -- Kshama Ring No. 3
        { item = 14683,        weight = 100 }, -- Kshama Ring No. 4
        { item = 14685,        weight = 100 }, -- Kshama Ring No. 5
        { item = 14687,        weight = 100 }, -- Kshama Ring No. 6
        { item = 13551,        weight = 100 }, -- Kshama Ring No. 8
        { item = 14686,        weight = 100 }, -- Kshama Ring No. 9
    },

    {
        quantity = 4,
        { item = xi.item.CHUNK_OF_ALUMINUM_ORE, weight = 1000 },
    },
}

return content:register()
