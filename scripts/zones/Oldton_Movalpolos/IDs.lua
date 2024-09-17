-----------------------------------
-- Area: Oldton_Movalpolos
-----------------------------------
zones = zones or {}

zones[xi.zone.OLDTON_MOVALPOLOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7579, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE       = 7710, -- Mining is possible here if you have <item>.
        ALTANA_DIE                    = 7736, -- Aaaltaaanaaa...Diiieee!!!
        MONSTER_APPEARED              = 7749, -- A monster has appeared!
        CHEST_UNLOCKED                = 7758, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL         = 8116, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.

        BRAKOBRIK_1                   = 7718, -- Stupid people. You don't getting what I'm saying.
        BRAKOBRIK_2                   = 7722, -- Killing bombs. Bringing *item*
        BRAKOBRIK_3                   = 7727, -- Good, good. You being smart. Very, very clever.
        BRAKOBRIK_4                   = 7730, -- When Brakobrik realizes that you already possess the item he is trying to give you, he refuses to give you another one.
        RAKOROK_DIALOGUE              = 7734, -- Nsy pipul. Gattohre! I bisynw!

        -- TODO: Shift IDs
        WAS_TAKEN_FROM_YOU            = 7748, -- The Dawn Talisman was taken from you...
    },
    mob =
    {
        BUGALLUG          = GetFirstID('Bugallug'),
        BUGBEAR_STRONGMAN = GetTableOfIDs('Bugbear_Strongman'),
        GOBLIN_WOLFMAN    = GetFirstID('Goblin_Wolfman'),
    },
    npc =
    {
        SCRAWLED_WRITING = GetFirstID('Scrawled_Writing'),
        OVERSEER_BASE    = GetFirstID('Conquest_Banner'),
        TREASURE_CHEST   = GetFirstID('Treasure_Chest'),
        MINING           = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.OLDTON_MOVALPOLOS]
