-----------------------------------
-- Test Your Mite
-- ENM 40
-- !addkeyitem ASTRAL_COVENANT
-----------------------------------
local shroudedMawID = zones[xi.zone.THE_SHROUDED_MAW]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.THE_SHROUDED_MAW,
    battlefieldId    = xi.battlefield.id.TEST_YOUR_MITE,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'MC_Entrance',
    exitNpc          = 'Memento_Circle',
    requiredKeyItems = { xi.ki.ASTRAL_COVENANT },
    grantXP          = 3500,
})

content:addEssentialMobs({ 'Pasuk' })

content.loot =
{
    {
        { item = xi.item.NONE, weight = 500 },
        { item = 14766,        weight = 250 }, -- Geist Earring
        { item = 15432,        weight = 250 }, -- Quick Belt
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
