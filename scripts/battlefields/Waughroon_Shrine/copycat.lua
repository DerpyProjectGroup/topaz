-----------------------------------
-- Copycat
-- Waughroon Shrine KSNM30, Clotho Orb
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.COPYCAT,
    maxPlayers       = 6,
    levelCap         = 99,
    timeLimit        = utils.minutes(30),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOTHO_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Osschaarts_Bat', 'Osschaarts_Wyvern', 'Osschaarts_Avatar', 'Osschaarts_Automaton' })
content.groups[1].spawned = false

content:addEssentialMobs({ 'Osschaart' })

content.loot =
{
    {
        { item = xi.item.ADAMAN_INGOT, weight = 1000 },
    },

    {
        { item = xi.item.AHRIMAN_LENS, weight = 250 },
        { item = xi.item.AHRIMAN_WING, weight = 250 },
        { item = xi.item.POLE_GRIP,    weight = 250 },
        { item = xi.item.SWORD_STRAP,  weight = 250 },
        { item = xi.item.SPEAR_STRAP,  weight = 250 },
    },

    {
        { item = xi.item.COFFINMAKER, weight = 250 },
        { item = xi.item.DESTROYERS,  weight = 250 },
        { item = xi.item.EXPUNGER,    weight = 250 },
        { item = xi.item.RETRIBUTOR,  weight = 250 },
    },

    {
        { item = xi.item.ATTILAS_EARRING, weight = 250 },
        { item = xi.item.DURANDAL,        weight = 250 },
        { item = xi.item.HOPLITES_HARPE,  weight = 250 },
        { item = xi.item.SORROWFUL_HARP,  weight = 250 },
    },

    {
        { item = xi.item.FUMA_SUNE_ATE,    weight = 550 },
        { item = xi.item.ADAMAN_INGOT,     weight = 200 },
        { item = xi.item.ORICHALCUM_INGOT, weight = 250 },
    },

    {
        { item = xi.item.CORAL_FRAGMENT,          weight = 50 },
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight = 50 },
        { item = xi.item.DEMON_HORN,              weight = 50 },
        { item = xi.item.EBONY_LOG,               weight = 50 },
        { item = xi.item.CHUNK_OF_GOLD_ORE,       weight = 50 },
        { item = xi.item.SPOOL_OF_GOLD_THREAD,    weight = 50 },
        { item = xi.item.HI_RERAISER,             weight = 50 },
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,   weight = 50 },
        { item = xi.item.MAHOGANY_LOG,            weight = 50 },
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,  weight = 50 },
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,    weight = 50 },
        { item = xi.item.PETRIFIED_LOG,           weight = 50 },
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight = 50 },
        { item = xi.item.RAM_HORN,                weight = 50 },
        { item = xi.item.SQUARE_OF_RAXA,          weight = 50 },
        { item = xi.item.RERAISER,                weight = 50 },
        { item = xi.item.VILE_ELIXIR,             weight = 50 },
        { item = xi.item.VILE_ELIXIR_P1,          weight = 50 },
        { item = xi.item.WYVERN_SCALES,           weight = 50 },
        { item = xi.item.PHILOSOPHERS_STONE,      weight = 50 },
    },

    {

        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight = 50 },
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight = 50 },
        { item = xi.item.DAMASCUS_INGOT,             weight = 50 },
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,     weight = 50 },
        { item = xi.item.PHILOSOPHERS_STONE,         weight = 300 },
        { item = xi.item.PHOENIX_FEATHER,            weight = 300 },
        { item = xi.item.SQUARE_OF_RAXA,             weight = 200 },
    },
}

return content:register()
