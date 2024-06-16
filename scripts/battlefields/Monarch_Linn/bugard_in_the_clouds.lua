-----------------------------------
-- Area: Monarch Linn
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.BUGARD_IN_THE_CLOUDS,
    maxPlayers       = 18,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 4,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.ki.MONARCH_BEARD, message = ID.text.KI_TORN },
    grantXP          = 2500,
})

content:addEssentialMobs({ 'Hotupuku' })

content.loot =
{
    {
        { item = xi.item.NONE, weight = 250 },
        { item = 17133,        weight = 250 }, -- Chanter's Staff
        { item = 16965,        weight = 250 }, -- Koryukagemitsu
        { item = 18411,        weight = 250 }, -- Buboso
    },

    {
        { item = xi.item.NONE,         weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.CLOUD_EVOKER, weight = xi.loot.weight.LOW            },
    },

    {
        quantity = 2,
        { item = xi.item.NONE, weight = 600 },
        { item = 14682,        weight = 100 }, -- Kshama Ring No. 2
        { item = 14683,        weight = 100 }, -- Kshama Ring No. 4
        { item = 14685,        weight = 100 }, -- Kshama Ring No. 5
        { item = 14686,        weight = 100 }, -- Kshama Ring No. 9
    },

    {
        quantity = 2,
        { item = xi.item.CHUNK_OF_ALUMINUM_ORE, weight = 1000 },
    },
}

return content:register()
