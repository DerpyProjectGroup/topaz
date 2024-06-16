-----------------------------------
-- Totentanz
-- Boneyard Gully ENM, Miasma Filter
-- !addkeyitem MIASMA_FILTER
-----------------------------------
local boneyardGullyID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.TOTENTANZ,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 4,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    requiredKeyItems = { xi.ki.MIASMA_FILTER },
    armouryCrates    =
    {
        boneyardGullyID.mob.GWYN_AP_KNUDD + 10,
        boneyardGullyID.mob.GWYN_AP_KNUDD + 21,
        boneyardGullyID.mob.GWYN_AP_KNUDD + 32,
    },

    grantXP = 3500,

    experimental = false,
})

content:addEssentialMobs({ 'Gwyn_Ap_Knudd', 'Cadaver_Warrior', 'Cadaver_Witch', 'Erdgeist' })

content.loot =
{
    {
        { item = xi.item.NONE,                   weight = 150 },
        { item = xi.item.PIECE_OF_CASSIA_LUMBER, weight = 375 },
        { item = xi.item.UNICORN_HORN,           weight = 225 },
        { item = xi.item.DRAGON_BONE,            weight = 250 },
    },
    
    {
        { item = xi.item.NONE,                     weight = 325 },
        { item = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = 325 },
        { item = xi.item.POT_OF_VIRIDIAN_URUSHI,   weight = 350 },
    },

    {
        { item = xi.item.NONE,         weight = 800 },
        { item = xi.item.CLOUD_EVOKER, weight = 200 },
    },

    {
        { item = xi.item.NONE,           weight = 325 },
        { item = xi.item.STONE_SPLITTER, weight = 150 },
        { item = xi.item.FRENZY_FIFE,    weight = 175 },
        { item = xi.item.BLAU_DOLCH,     weight = 250 },
        { item = xi.item.ONIMARU,        weight = 100 },
    },

    {
        { item = xi.item.NONE,           weight = 670 },
        { item = xi.item.MANEATER,       weight = 100 },
        { item = xi.item.WAGH_BAGHNAKHS, weight = 65 },
        { item = xi.item.RAISE_II_ROD,   weight = 65 },
        { item = xi.item.CORSE_CAPE,     weight = 100 },
    },
}

return content:register()
