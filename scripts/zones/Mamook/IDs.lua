-----------------------------------
-- Area: Mamook
-----------------------------------
zones = zones or {}

zones[xi.zone.MAMOOK] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7057, -- You can't fish here.
        LOGGING_IS_POSSIBLE_HERE      = 7542, -- Logging is possible here if you have <item>.
        PARTY_MEMBERS_HAVE_FALLEN     = 7899, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7906, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        IMPENDING_BATTLE              = 8055, -- You feel the rush of impending battle!
        NUMEROUS_STRANDS              = 8652, -- Numerous strands of hair are scattered all over...
        SICKLY_SWEET                  = 8654, -- A sickly sweet fragrance pervades the air...
        DRAWS_NEAR                    = 8676, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9547, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.

        KEYHOLE                       = 8119, -- There is a giant keyhole in the gate here. You can see smearings of black, silver, brown, and other colors around the keyhole.
        KEYS_SHATTER                  = 8120, -- The <item> shatters...The <item> shatters...The <item> shatters...
        GULOOL_ENGAGE                 = 8153, -- See it, can we? Yes, see it, we can. Mamool Ja, it is not. No scales, does it have. And so, the Imperial tongue, we speak?
        GULOOL_DEAD                   = 8154, -- Dead, am I? And you? Dead as well, am I. Then finished, we are...
    },
    mob =
    {
        ZIZZY_ZILLAH         = GetFirstID('Zizzy_Zillah'),
        FIREDANCE_MAGMAAL_JA = GetFirstID('Firedance_Magmaal_Ja'),
        GULOOL_JA_JA         = GetFirstID('Gulool_Ja_Ja'),
        CHAMROSH             = GetFirstID('Chamrosh'),
        IRIRI_SAMARIRI       = GetFirstID('Iriri_Samariri'),
        POROGGO_CASANOVA     = GetFirstID('Poroggo_Casanova'),
        MIKILULU             = GetFirstID('Mikilulu'),
        MIKIRURU             = GetFirstID('Mikiruru'),
        NIKILULU             = GetFirstID('Nikilulu'),
        MIKILURU             = GetFirstID('Mikiluru'),
        MIKIRULU             = GetFirstID('Mikirulu'),
        VENOMFANG            = GetFirstID('Venomfang'),
        DEVOUT_RADOL_JA          = 17043532,
        DRAGONSCALED_BUGAAL_JA   = 17043626,
        HUNDREDFACED_HAPOOL_JA   = 17043665,
        DARTING_KACHAAL_JA       = 17043736,
    },
    npc =
    {
        LOGGING = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.MAMOOK]
