-----------------------------------
-- Area: RaKaznar_Inner_Court
-----------------------------------
zones = zones or {}

zones[xi.zone.RAKAZNAR_INNER_COURT] =
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
        HOMEPOINT_SET                 = 7693, -- Home point set!
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Heliotrope_Barrier'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_7o0'),
    },
    reive =
    {
        [1] =
        {
            mob =
            {
                17908145,
                17908146,
                17908147,
                17908148,
            },
            obstacles =
            {
                17908142,
                17908143,
                17908144,
            },
            collision =
            {
                17908242,
            },
        },
        [2] =
        {
            mob =
            {
                17908152,
                17908153,
                17908154,
                17908155,
            },
            obstacles =
            {
                17908149,
                17908150,
                17908151,
            },
            collision =
            {
                17908243,
            },
        },
        [3] =
        {
            mob =
            {
                17908159,
                17908160,
                17908161,
                17908162,
            },
            obstacles =
            {
                17908156,
                17908157,
                17908158,
            },
            collision =
            {
                17908244,
            },
        },
        [4] =
        {
            mob =
            {
                17908166,
                17908167,
                17908168,
                17908169,
            },
            obstacles =
            {
                17908163,
                17908164,
                17908165,
            },
            collision =
            {
                17908245,
            },
        },
    },
}

return zones[xi.zone.RAKAZNAR_INNER_COURT]
