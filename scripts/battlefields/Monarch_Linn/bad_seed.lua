-----------------------------------
-- Area: Monarch Linn
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.BAD_SEED,
    maxPlayers       = 18,
    levelCap         = 40,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.ki.MONARCH_BEARD, message = ID.text.KI_TORN },
    grantXP          = 2500,
})

content:addEssentialMobs({ 'Hamadryad' })

content.loot =
{
    {
        { item = xi.item.NONE, weight = 500 },
        { item = 15433,        weight = 250 }, -- Reverend Sash
        { item = 15434,        weight = 250 }, -- Vanguard Belt
    },

    {
        { item = xi.item.NONE,         weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.CLOUD_EVOKER, weight = xi.loot.weight.LOW            },
    },

    {
        quantity = 2,
        { item = xi.item.NONE, weight = 250 },
        { item = 13550,        weight = 125 }, -- Crossbowmans Ring
        { item = 14675,        weight = 125 }, -- Woodsman Ring
        { item = 13549,        weight = 125 }, -- Ether Ring
    },
}

return content:register()
