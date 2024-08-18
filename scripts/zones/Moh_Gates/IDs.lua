-----------------------------------
-- Area: Moh_Gates
-----------------------------------
zones = zones or {}

zones[xi.zone.MOH_GATES] =
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
        REIVE_COLLISION_OFFSET = GetFirstID('_7h0'),
    },
    reive =
    {
        [1] =
        {
            mob =
            {
                17879168,
                17879169,
                17879170,
                17879171,
                17879172,
                17879173,
            },
            obstacles =
            {
                17879165,
                17879166,
                17879167,
            },
            collision =
            {
                17879396,
                17879397,
            },
        },
        [2] =
        {
            mob =
            {
                17879177,
                17879178,
                17879179,
                17879180,
                17879181,
                17879182,
            },
            obstacles =
            {
                17879174,
                17879175,
                17879176,
            },
            collision =
            {
                17879394,
                17879395,
            },
        },
    },
}

return zones[xi.zone.MOH_GATES]
