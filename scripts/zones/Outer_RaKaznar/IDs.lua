-----------------------------------
-- Area: Outer_RaKaznar
-----------------------------------
zones = zones or {}

zones[xi.zone.OUTER_RAKAZNAR] =
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
        BAYLD_OBTAINED                = 7007, -- You have obtained <number> bayld!
        FAINT_ENERGY_WAFTS            = 7013, -- A faint energy wafts up from the ground.
        YOU_HAVE_LEARNED              = 7015, -- You have learned <keyitem>!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        THIS_BAFFLING_GADGET          = 7741, -- This baffling gadget seems to serve as transport to the [lower/higher] floors.
        HAVE_FOUND_SCALES             = 7907, -- You have found <number> scale[/s].
        SOOTHING_SIGH_FALLS           = 7908, -- A soothing sigh falls upon your ears. Could you have found the final scale?
        DOOR_TIGHTLY_SEALED           = 7909, -- The door is tightly sealed.
        EERIE_GLOW_PENETRATES         = 7910, -- An eerie glow penetrates the darkness.
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Amaranth_Barrier'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_7m0'),
    },
    reive =
    {
        [1] =
        {
            mob =
            {
                17899799,
                17899800,
                17899801,
                17899802,
            },
            obstacles =
            {
                17899796,
                17899797,
                17899798,
            },
            collision =
            {
                17899944,
            },
        },
        [2] =
        {
            mob =
            {
                17899806,
                17899807,
                17899808,
                17899809,
            },
            obstacles =
            {
                17899803,
                17899804,
                17899805,
            },
            collision =
            {
                17899945,
            },
        },
        [3] =
        {
            mob =
            {
                17899813,
                17899814,
                17899815,
                17899816,
            },
            obstacles =
            {
                17899810,
                17899811,
                17899812,
            },
            collision =
            {
                17899947,
            },
        },
        [4] =
        {
            mob =
            {
                17899820,
                17899821,
                17899822,
                17899823,
            },
            obstacles =
            {
                17899817,
                17899818,
                17899819,
            },
            collision =
            {
                17899946,
            },
        },
    },
}

return zones[xi.zone.OUTER_RAKAZNAR]
