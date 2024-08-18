-----------------------------------
-- Area: Cirdas_Caverns
-----------------------------------
zones = zones or {}

zones[xi.zone.CIRDAS_CAVERNS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Knotted_Root'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_pim'),
    },
    reive =
    {
        [1] =
        {
            mob =
            {
                17883612,
                17883613,
                17883614,
                17883615,
            },
            obstacles =
            {
                17883610,
                17883611,
            },
            collision =
            {
                17883896,
                17883897,
            },
        },
        [2] =
        {
            mob =
            {
                17883618,
                17883619,
                17883620,
                17883621,
            },
            obstacles =
            {
                17883616,
                17883617,
            },
            collision =
            {
                17883884,
                17883885,
            },
        },
        [3] =
        {
            mob =
            {
                17883624,
                17883625,
                17883626,
                17883627,
            },
            obstacles =
            {
                17883622,
                17883623,
            },
            collision =
            {
                17883892,
                17883893,
            },
        },
        [4] =
        {
            mob =
            {
                17883630,
                17883631,
                17883632,
                17883633,
            },
            obstacles =
            {
                17883628,
                17883629,
            },
            collision =
            {
                17883894,
                17883895,
            },
        },
        [5] =
        {
            mob =
            {
                17883636,
                17883637,
                17883638,
                17883639,
            },
            obstacles =
            {
                17883634,
                17883635,
            },
            collision =
            {
                17883888,
                17883889,
            },
        },
        [6] =
        {
            mob =
            {
                17883642,
                17883643,
                17883644,
                17883645,
            },
            obstacles =
            {
                17883640,
                17883641,
            },
            collision =
            {
                17883886,
                17883887,
            },
        },
    },
}

return zones[xi.zone.CIRDAS_CAVERNS]
